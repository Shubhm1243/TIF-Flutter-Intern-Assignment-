import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 271,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f6f7ec8),
            offset: Offset(0, 10),
            blurRadius: 17.5,
          ),
        ],
        color: const Color(0xff5669ff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'BOOK NOW',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFF3D56F0),
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Color(0xffffffff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
