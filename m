Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61D39768C
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908698; cv=pass; b=paV1qFmf/OJrtTI23vwDo2uKexizcm0Mf5u23UUkr25qLaNQ3ZbP3VTJTiRhoLf4/qbtktTAUWF5bzJFz7PUctKKUD0a6SQhYVIG7Qn6qouBo8rtW3vMiLQd6jeSmYy1CKNSKUCre7YvEcNNyNrTJx+cTD2YNiweKEHVHL2xMfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908698; c=relaxed/simple;
	bh=CKNvhZhTHShX0NS9xBImUHIABjidvgSWuC6+VkrGfek=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=krD9AdU0ktpOq3DM3aKeIkcL2rypywXjsoCQ0PAmPPVYt5ySdhUhuAaKspSi9kbNTQDMQXdG8p5k45h0JsQUnPw8zjgt+b0ODm/yPKnH2i8jpngKRc0KcHwsrgNdw5+yWtjbBAInJh71z5WxSE+gAkb7Y8I+WUvyLcnIkE8juaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxO2V9In; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxO2V9In"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4563ac048f4so999320fac.0
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 02:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787908689; cv=none;
        d=google.com; s=arc-20260327;
        b=IlImm2EN+kDHn5ejBdOUHn1uakK2BzN0xJJ5XLPaXG2AV8MT/cIQnLmGlNwuYucHEg
         FebDqm+uJMhoyJ4My4t1PLRUnsK3OTGr3G3i23pa2vsz/ixzVXcAUIlO9x3d/UgTOzqN
         cXIh7Ha1fvC3aofGYDHvU237N3F4Jzw+QCNaKpI3oLBkdhnRTr84LaGdjVxRtuV1DCNd
         4o83SNM+RxEkA3quXEFuaZMCuYp1ZKpJgiawoTbKhwbIJlOyPI6bMf3UFS3KxlyiI8ml
         K82bNr8/ZBZRaFrDUhFceXSZxBTBRinfM0qZoqP2pdq4GuyUz8+sFKdisvPKq+pXkyEY
         42FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=y7bd2jvc/X03ECvfw453wTu5iFVuotqJ65ih+x9VWuY=;
        fh=34UiwQxnVfWDIG5RezE2n654k/hUlpWv3CTaiWKCn54=;
        b=dVbtcslF/XKV7H4CK7o3e1lYLkjEkfQL9SwC1VC77Gxw9pUIUuKx29tcQYu7BPNAV8
         Mx/mbqhJ0ZNk4KfKZdMcmfDBI75AFhx3H0OK7Q95oPaSKALZt6v/wg8eDfpeNqgRpFi1
         t10IzctaJYmIjdrbhrrrdNz97ehqDQENqj0ScOWtkrm0X0IECPBccf49JLGozvbngDgv
         SPTQw8mOEjI9yhDEhfQih5qe9K7PeO3QYCqF/PixH9OBgZEcqZyxHsvYwz+Dx1Fj7D14
         TYsgzv68SheZerItzteAA+hO3oV3nH+Q4EmQjnU1H119iMe9Qz9zr5PAD9txBwMqqRwb
         ToCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787908689; x=1788513489; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7bd2jvc/X03ECvfw453wTu5iFVuotqJ65ih+x9VWuY=;
        b=fxO2V9In41Ae5hTNi3YN4so6ZNOWZwF1C56jcbKyxEj30VYSd590HfTGP3VN3ez9g5
         ykn7ldFXxaGEcijbI7CZR4U2uU9Z8dhDRRAUq9b5zrHPKOED+XYz9pRYIjQu5cIB0dMU
         6nV33G38dX1fkWT2vyoK06fXmQ/v5AXf3lgd4ZVFaiz/06vy/3lIYDQvlm8+NbIwYSc8
         zOD4dkxaOzgIZ470k1bdwOuKZ9XL1NQwLssMbtnVFoEKoybITRWtuzz4wSJmLD/4Kw9f
         ftBn0IGWOyYUA9MYkMulygeQyLE5l8PjFY2ZCRO0tMextj4CvcCSz9AZ/RlMe2kGZvt6
         msDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908689; x=1788513489;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y7bd2jvc/X03ECvfw453wTu5iFVuotqJ65ih+x9VWuY=;
        b=ht/AaPrdrlBUF+xiPrmFkgHR1rmOs1lylk/6IdUenSLdiVSPf6qDCXpEDUpQqEwBIt
         bwNXCuERHZjNqE+WV8VZ6RV2626Cn2ya+/tSITvxvNV/9vm+KKlKM3tmh1je5hStJCdC
         xtmt5CfuwY9u6eJIkB15YpFkpPWW1YSQ+xVmUOXoQkyIqe+OMi6wDql/OmlO/DfhxSBo
         PJC9k79Xg5/8LD00bcwn7EQ1u3VqH6JIC5nfEY2js7qBM6wN/SBncx9rEc8Y6qx7unbx
         5Rx2BsVlGnuPpSQy1mvRQX49IWXiisN03q+fPA5jntWYDW7J3fepCZ05Dc2o5I52SgjN
         0b/A==
X-Gm-Message-State: AFuF++mGdOjilnGEXoCCdj4fxaXiKNFJd8Iw9NI+TLy6FAOotIW+0HZh
	ORbBI+GhHyOnAT84MZuBmhSkbsRgeaWmzdK9NPlBgiRJgWZ1cf+65f3TAaRMBJA49l2GrcFb69u
	UiRoj9iwoVPWFbOZsmNClSj4VLqE4o4jaQrHw9XGYtg==
X-Gm-Gg: AR+sD12sI+1fCzdM8cZGQ6ZqD2Ex4Sb+3BIhYnsqFmGsFp4pR7dgT0Devf4ZXwhj+7S
	jsEJoRGH0QOVkpv8hxAr06cnG0cUKBxsYw4MLT9AxaSsXCrGKp2xr47M9ohG6NkT515/DBBQPEd
	+CcX1YStm7hRJ1TuA5YWcBBZ8HzmYkofe+mwKWP0FKSc8+MNtADcz4sGLXMTDp8TnorNw+TgzuN
	CbdVZItczaDoITG94M2HXw9Fmf3p6eyvk+Qk3IG8OBdF3460Zjmh4HhNs2fukDO+fVD5OVV6S0C
	kqcY1hh21gsaVZ+s5P9SQMjtevNI2YVeGnhtckNcmuA=
X-Received: by 2002:a05:6870:9a8f:b0:452:2f:49b0 with SMTP id
 586e51a60fabf-4683590276fmr6985514fac.4.1787908688740; Fri, 28 Aug 2026
 02:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hiker Cl <clhiker365@gmail.com>
Date: Fri, 28 Aug 2026 17:17:56 +0800
X-Gm-Features: AcwNN1UGtBBVGu8caWRkJZEO9OAsDKP6Wx1xp9iYIYgZmDNYHI3nNDN1BnpBu5A
Message-ID: <CAGM=xGDG8BxGPdRvs8rL=0e=_MPQAck-LbnMdttNptZXLKf5eA@mail.gmail.com>
Subject: WARNING in bpf_mark_chain_precision - backtracking misuse on bpf_loop
 callback with uninitialized r1
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000489f19065a17eea8"

--000000000000489f19065a17eea8
Content-Type: text/plain; charset="UTF-8"

Hi BPF maintainers,

I'm reporting a kernel WARNING (verifier internal-invariant violation) I
encountered on the BPF subsystem, reproducible on Linux 7.2.0-rc6
(bpf-next f79066c78) and 7.2.0-rc7 (mainline 15ef2f78c).

### Summary
A 21-instruction SOCKET_FILTER program that calls bpf_loop() from a subprog
with the nr_loops register (r1 at the call site) left uninitialized
triggers:

    verifier bug: backtracking misuse
    WARNING: kernel/bpf/backtrack.c:819 at
bpf_mark_chain_precision+0x2f61/0x50d0

The program has an uninitialized register (r1 at the bpf_loop call site)
and should be rejected with the normal "R1 !read_ok" error. Instead, on
the callback pre-verification path, precision backtracking walks across
frames, hits a non-SCALAR register (NOT_INIT) in the caller frame, and
fails the defensive sanity check in bpf_mark_chain_precision() -- a
verifier_bug() that must never be reachable from user input.

### Steps to Reproduce (raw instruction sequence)
A complete standalone reproducer (pure syscall, no libbpf; embeds the
minimal BTF blob and func_info needed for the BPF_PSEUDO_FUNC callback)
is attached (poc_backtrack1.c). Build with `gcc -O2 -o poc_backtrack1
poc_backtrack1.c`, run as root (CAP_BPF); the trigger is printed from the
verifier log on every run.

    main (0-3):
     0  r6 = 4
     1  call subprog          /* pseudo call -> insn 4 */
     2  r0 = 0
     3  exit

    subprog (4-13):
     4  r7 = 2
     5-6  r2 = callback       /* LD_IMM64, BPF_PSEUDO_FUNC -> insn 14 */
     7  r3 = r10
     8  r3 += -8
     9  *(u64 *)(r10 - 8) = 0
    10  r4 = 1
    11  r0 = bpf_loop(181)    /* (*) r1 (nr_loops) never set in this frame */
    12  r0 = 1
    13  exit

    callback (14-20):
    14  r2 = r1               /* index */
    15  if r2 == 1 goto +3
    16  r2 += 1
    17  r2 &= 7
    18  *(u64 *)(r10 - 16) = r2
    19  r0 = 1
    20  exit

Full bug report (with kernel log) is filed on Bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=221899

### Notes
This message ("backtracking misuse", backtrack.c:819) is distinct from
the syzbot reports "WARNING in __mark_chain_precision": those fire inside
backtrack_insn() with message "verifier backtracking bug", while ours is
the entry-point guard in bpf_mark_chain_precision()
(reg->type != SCALAR_VALUE) reached across frames via the bpf_loop
callback pre-verification path.

Please let me know if you need more information or if I can help test a
patch. The poc is in the attachment.

--000000000000489f19065a17eea8
Content-Type: text/plain; charset="US-ASCII"; name="poc_backtrack1.c"
Content-Disposition: attachment; filename="poc_backtrack1.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtcqliif0>
X-Attachment-Id: f_mtcqliif0

Ly8gUG9jIGZvcjogV0FSTklORyBpbiBrZXJuZWwvYnBmL2JhY2t0cmFjay5jOjgxOSAodmVyaWZp
ZXJfYnVnDQovLyAiYmFja3RyYWNraW5nIG1pc3VzZSIpIC0tIGJwZl9sb29wIGNhbGxiYWNrIHBy
ZS12ZXJpZmljYXRpb24gaGl0cyBhbg0KLy8gdW5pbml0aWFsaXplZCByZWdpc3RlciAoTk9UX0lO
SVQpIGFjcm9zcyBmcmFtZXMgZHVyaW5nIHByZWNpc2lvbg0KLy8gYmFja3RyYWNraW5nLg0KLy8N
Ci8vIEJ1aWxkOiBnY2MgLU8yIC1vIHBvY19iYWNrdHJhY2sxIHBvY19iYWNrdHJhY2sxLmMNCi8v
IFJ1biAoYXMgcHJpdmlsZWdlZCB1c2VyLCBDQVBfQlBGIHJlcXVpcmVkKToNCi8vICAgLi9wb2Nf
YmFja3RyYWNrMQ0KLy8NCi8vIERldGVybWluaXN0aWMgdHJpZ2dlciAodmVyaWZpZWQgNC80KTog
bWFpbiAtPiBzdWJwcm9nIC0+IGJwZl9sb29wDQovLyBjYWxsYmFjaywgd2l0aCB0aGUgYnBmX2xv
b3AgY2FsbCBzaXRlJ3MgcjEgKG5yX2xvb3BzKSBsZWZ0DQovLyB1bmluaXRpYWxpemVkIGluIHRo
ZSBzdWJwcm9nIGZyYW1lLiBUaGUgcHJvZ3JhbSBzaG91bGQgYmUgY2xlYW5seQ0KLy8gcmVqZWN0
ZWQgd2l0aCAiUjEgIXJlYWRfb2siOyBpbnN0ZWFkLCBwYXJ0IG9mIHRoZSB2ZXJpZmljYXRpb24g
cGF0aA0KLy8gZmlyZXMgdmVyaWZpZXJfYnVnKCJiYWNrdHJhY2tpbmcgbWlzdXNlIikgYXQgYmFj
a3RyYWNrLmM6ODE5Lg0KLy8NCi8vIFRoZSBrZXJuZWwgcHJpbnRzIChkbWVzZywgZmlyc3Qgb2Nj
dXJyZW5jZSBwZXIgYm9vdCk6DQovLyAgIHZlcmlmaWVyIGJ1ZzogYmFja3RyYWNraW5nIG1pc3Vz
ZQ0KLy8gICBXQVJOSU5HOiBDUFU6IC4uLiBhdCBrZXJuZWwvYnBmL2JhY2t0cmFjay5jOjgxOQ0K
Ly8gICAgICAgICAgICBicGZfbWFya19jaGFpbl9wcmVjaXNpb24rMHguLi4vLi4uIA0KLy8gYW5k
IHRoZSB2ZXJpZmllciBsb2cgKGxvZ19sZXZlbD0yKSBjb250YWlucyB0aGUgc2FtZSAiYmFja3Ry
YWNraW5nDQovLyBtaXN1c2UiIGxpbmUgb24gZXZlcnkgb2NjdXJyZW5jZS4gVGhpcyBwb2MgcHJp
bnRzIHRoZSB2ZXJpZmllciBsb2cNCi8vIHRhaWwgc28gdGhlIHRyaWdnZXIgaXMgb2JzZXJ2YWJs
ZSBldmVuIGFmdGVyIFdBUk5fT05DRSBpcyBjb25zdW1lZC4NCiNpbmNsdWRlIDxlcnJuby5oPg0K
I2luY2x1ZGUgPGxpbnV4L2JwZi5oPg0KI2luY2x1ZGUgPHN0ZGludC5oPg0KI2luY2x1ZGUgPHN0
ZGlvLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4NCiNp
bmNsdWRlIDx1bmlzdGQuaD4NCg0KI2lmbmRlZiBfX05SX2JwZg0KI2RlZmluZSBfX05SX2JwZiAz
MjENCiNlbmRpZg0KDQovKiB1YXBpIGNvbnN0YW50cyB0aGF0IG1heSBiZSBtaXNzaW5nIGZyb20g
b2xkZXIgbGliYyBoZWFkZXJzICovDQojaWZuZGVmIEJQRl9QU0VVRE9fQ0FMTA0KI2RlZmluZSBC
UEZfUFNFVURPX0NBTEwgMQ0KI2VuZGlmDQojaWZuZGVmIEJQRl9QU0VVRE9fRlVOQw0KI2RlZmlu
ZSBCUEZfUFNFVURPX0ZVTkMgNA0KI2VuZGlmDQojZGVmaW5lIEJQRl9GVU5DX2xvb3AgMTgxDQoN
CnN0YXRpYyBpbnQgc3lzX2JwZihlbnVtIGJwZl9jbWQgY21kLCB1bmlvbiBicGZfYXR0ciAqYXR0
cikNCnsNCglyZXR1cm4gc3lzY2FsbChfX05SX2JwZiwgY21kLCBhdHRyLCBzaXplb2YoKmF0dHIp
KTsNCn0NCg0KLyogLS0tLSBpbnN0cnVjdGlvbiBidWlsZGVycyAocHVyZSBzeXNjYWxsLCBubyBs
aWJicGYpIC0tLS0gKi8NCiNkZWZpbmUgQlBGX1JBV19JTlNOKENPREUsIERTVCwgU1JDLCBPRkYs
IElNTSkgXA0KCSgoc3RydWN0IGJwZl9pbnNuKXsgLmNvZGUgPSBDT0RFLCAuZHN0X3JlZyA9IERT
VCwgLnNyY19yZWcgPSBTUkMsIFwNCgkJCSAgICAub2ZmID0gT0ZGLCAuaW1tID0gSU1NIH0pDQoj
ZGVmaW5lIEJQRl9NT1Y2NF9JTU0oRFNULCBJTU0pIEJQRl9SQVdfSU5TTihCUEZfQUxVNjQgfCBC
UEZfTU9WIHwgQlBGX0ssIERTVCwgMCwgMCwgSU1NKQ0KI2RlZmluZSBCUEZfTU9WNjRfUkVHKERT
VCwgU1JDKSBCUEZfUkFXX0lOU04oQlBGX0FMVTY0IHwgQlBGX01PViB8IEJQRl9YLCBEU1QsIFNS
QywgMCwgMCkNCiNkZWZpbmUgQlBGX0FMVTY0X0lNTShPUCwgRFNULCBJTU0pIEJQRl9SQVdfSU5T
TihCUEZfQUxVNjQgfCBCUEZfT1AoT1ApIHwgQlBGX0ssIERTVCwgMCwgMCwgSU1NKQ0KI2RlZmlu
ZSBCUEZfU1RfTUVNKFNJWkUsIERTVCwgT0ZGLCBJTU0pIEJQRl9SQVdfSU5TTihCUEZfU1QgfCBC
UEZfU0laRShTSVpFKSB8IEJQRl9NRU0sIERTVCwgMCwgT0ZGLCBJTU0pDQojZGVmaW5lIEJQRl9T
VFhfTUVNKFNJWkUsIERTVCwgU1JDLCBPRkYpIEJQRl9SQVdfSU5TTihCUEZfU1RYIHwgQlBGX1NJ
WkUoU0laRSkgfCBCUEZfTUVNLCBEU1QsIFNSQywgT0ZGLCAwKQ0KI2RlZmluZSBCUEZfSk1QX0lN
TShPUCwgRFNULCBJTU0sIE9GRikgQlBGX1JBV19JTlNOKEJQRl9KTVAgfCBCUEZfT1AoT1ApIHwg
QlBGX0ssIERTVCwgMCwgT0ZGLCBJTU0pDQojZGVmaW5lIEJQRl9DQUxMX1JFTChPRkYpIEJQRl9S
QVdfSU5TTihCUEZfSk1QIHwgQlBGX0NBTEwsIDAsIEJQRl9QU0VVRE9fQ0FMTCwgMCwgT0ZGKQ0K
I2RlZmluZSBCUEZfQ0FMTF9GVU5DKElEKSBCUEZfUkFXX0lOU04oQlBGX0pNUCB8IEJQRl9DQUxM
LCAwLCAwLCAwLCBJRCkNCiNkZWZpbmUgQlBGX0VYSVRfSU5TTigpIEJQRl9SQVdfSU5TTihCUEZf
Sk1QIHwgQlBGX0VYSVQsIDAsIDAsIDAsIDApDQojZGVmaW5lIEJQRl9MRF9JTU02NF9SQVcoRFNU
LCBTUkMsIElNTSkgXA0KCUJQRl9SQVdfSU5TTihCUEZfTEQgfCBCUEZfRFcgfCBCUEZfSU1NLCBE
U1QsIFNSQywgMCwgSU1NKSwgXA0KCUJQRl9SQVdfSU5TTigwLCAwLCAwLCAwLCAwKQ0KI2RlZmlu
ZSBCUEZfTERfUFNFVURPX0ZVTkMoRFNULCBSRUwpIEJQRl9MRF9JTU02NF9SQVcoRFNULCBCUEZf
UFNFVURPX0ZVTkMsIFJFTCkNCg0KLyogLS0tLSBtaW5pbWFsIEJURiBibG9iICh2MiwgMTE5IGJ5
dGVzKTogSU5UICsgUFRSICsgRlVOQ19QUk9UTyhyZXQ9aW50LA0KICogdmxlbj0yLCBhcmdzIFBU
UikgKyBGVU5DICdjYWxsYmFja19mbicgc3RhdGljLiBTYW1lIGxheW91dCBhcyB1c2VkIGJ5DQog
KiB0aGUgZnJhbWV3b3JrIGV4ZWN1dG9yOyBwaW5uZWQgaW4ga2VybmVsIEVCVEYgZXhwZWN0YXRp
b25zOg0KICogICB0eXBlIDEgPSBJTlQgKHNpemUgNCwgYml0cyAzMikNCiAqICAgdHlwZSAyID0g
UFRSDQogKiAgIHR5cGUgMyA9IEZVTkNfUFJPVE8gKHJldCBpbnQsIDIgUFRSIHBhcmFtcykNCiAq
ICAgdHlwZSA0ID0gRlVOQyAnY2FsbGJhY2tfZm4nIChsaW5rYWdlIFNUQVRJQywgdmxlbiAwKQ0K
ICogRlVOQyB0eXBlIGlkIHVzZWQgZm9yIGZ1bmNfaW5mbyByZWNvcmRzIGlzIDQuIC0tLS0gKi8N
CnN0YXRpYyBjb25zdCB1bnNpZ25lZCBjaGFyIGJ0Zl9ibG9iX21pbltdID0gew0KCTB4OWYsIDB4
ZWIsIDB4MDEsIDB4MDAsIDB4MTgsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAs
IDB4MDAsDQoJMHg0NCwgMHgwMCwgMHgwMCwgMHgwMCwgMHg0NCwgMHgwMCwgMHgwMCwgMHgwMCwg
MHgxYiwgMHgwMCwgMHgwMCwgMHgwMCwNCgkweDAxLCAweDAwLCAweDAwLCAweDAwLCAweDAwLCAw
eDAwLCAweDAwLCAweDAxLCAweDA0LCAweDAwLCAweDAwLCAweDAwLA0KCTB4MjAsIDB4MDAsIDB4
MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDIs
DQoJMHgwMSwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMiwg
MHgwMCwgMHgwMCwgMHgwZCwNCgkweDAxLCAweDAwLCAweDAwLCAweDAwLCAweDExLCAweDAwLCAw
eDAwLCAweDAwLCAweDAyLCAweDAwLCAweDAwLCAweDAwLA0KCTB4MTYsIDB4MDAsIDB4MDAsIDB4
MDAsIDB4MDIsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDUsIDB4MDAsIDB4MDAsIDB4MDAsDQoJMHgw
MCwgMHgwMCwgMHgwMCwgMHgwYywgMHgwMywgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMCwgMHg2OSwg
MHg2ZSwgMHg3NCwNCgkweDAwLCAweDYzLCAweDYxLCAweDZjLCAweDZjLCAweDYyLCAweDYxLCAw
eDYzLCAweDZiLCAweDVmLCAweDY2LCAweDZlLA0KCTB4MDAsIDB4NjEsIDB4NzIsIDB4NjcsIDB4
MzAsIDB4MDAsIDB4NjEsIDB4NzIsIDB4NjcsIDB4MzEsIDB4MDAsDQp9Ow0KI2RlZmluZSBCVEZf
VFlQRV9GVU5DX0NBTExCQUNLIDQNCg0KLyogZnVuY19pbmZvIHJlY29yZHM6IGVudHJ5IChpbnNu
IDApICsgc3VicHJvZyAoaW5zbiA0KSArIGNhbGxiYWNrIChpbnNuIDE0KS4NCiAqIGluc25fb2Zm
IGlzIGluIElOU1RSVUNUSU9OIElOREVYIHVuaXRzIChtYXRjaGVzIHN1YnByb2dfaW5mb1tpXS5z
dGFydA0KICogaW4gdGhlIGtlcm5lbCdzIGNoZWNrX2J0Zl9mdW5jIG9uIHRoaXMga2VybmVsKS4g
Ki8NCnN0YXRpYyBzdHJ1Y3QgYnBmX2Z1bmNfaW5mbyBmdW5jX2luZm9bXSA9IHsNCgl7IC5pbnNu
X29mZiA9IDAsICAudHlwZV9pZCA9IEJURl9UWVBFX0ZVTkNfQ0FMTEJBQ0sgfSwNCgl7IC5pbnNu
X29mZiA9IDQsICAudHlwZV9pZCA9IEJURl9UWVBFX0ZVTkNfQ0FMTEJBQ0sgfSwNCgl7IC5pbnNu
X29mZiA9IDE0LCAudHlwZV9pZCA9IEJURl9UWVBFX0ZVTkNfQ0FMTEJBQ0sgfSwNCn07DQoNCiNk
ZWZpbmUgTE9HX1NJWkUgKDY0ICogMTAyNCkNCnN0YXRpYyBjaGFyIHZsb2dbTE9HX1NJWkVdOw0K
DQppbnQgbWFpbih2b2lkKQ0Kew0KCS8qIDEuIGxvYWQgbWluaW1hbCBCVEYgKi8NCgl1bmlvbiBi
cGZfYXR0ciBiID0ge307DQoJYi5idGYgPSAodWludDY0X3QpKHVpbnRwdHJfdClidGZfYmxvYl9t
aW47DQoJYi5idGZfc2l6ZSA9IHNpemVvZihidGZfYmxvYl9taW4pOw0KCWludCBidGZfZmQgPSBz
eXNfYnBmKEJQRl9CVEZfTE9BRCwgJmIpOw0KCWlmIChidGZfZmQgPCAwKSB7DQoJCXByaW50Zigi
QlBGX0JURl9MT0FEIGZhaWxlZDogZXJybm89JWQgKCVzKVxuIiwgZXJybm8sIHN0cmVycm9yKGVy
cm5vKSk7DQoJCXJldHVybiAxOw0KCX0NCg0KCS8qIDIuIHByb2dyYW06IG1haW4gLT4gc3VicHJv
ZyAtPiBicGZfbG9vcCBjYWxsYmFjay4NCgkgKiBUaGUgc3VicHJvZyBmcmFtZSBjYWxscyBicGZf
bG9vcCB3aXRoIHIxIChucl9sb29wcykgbmV2ZXIgc2V0LiAqLw0KCXN0cnVjdCBicGZfaW5zbiBp
bnNuc1tdID0gew0KCQkvKiBtYWluICgwLTMpOiBjYWxsIHN1YnByb2cgKHBzZXVkbyBjYWxsLCBy
ZWwgKzIgLT4gaW5zbiA0KSAqLw0KCQlCUEZfTU9WNjRfSU1NKEJQRl9SRUdfNiwgNCksICAgICAg
ICAgICAgICAvKiAwOiByNiA9IDQgKi8NCgkJQlBGX0NBTExfUkVMKDIpLCAgICAgICAgICAgICAg
ICAgICAgICAgICAgLyogMTogY2FsbCBzdWJwcm9nIChpbnNuIDQpICovDQoJCUJQRl9NT1Y2NF9J
TU0oQlBGX1JFR18wLCAwKSwgICAgICAgICAgICAgIC8qIDI6IHIwID0gMCAqLw0KCQlCUEZfRVhJ
VF9JTlNOKCksICAgICAgICAgICAgICAgICAgICAgICAgICAvKiAzOiBleGl0ICovDQoNCgkJLyog
c3VicHJvZyAoNC0xMyk6IGJwZl9sb29wIHdpdGggdW5pbml0aWFsaXplZCByMSAqLw0KCQlCUEZf
TU9WNjRfSU1NKEJQRl9SRUdfNywgMiksICAgICAgICAgICAgICAvKiA0OiByNyA9IDIgKi8NCgkJ
QlBGX0xEX1BTRVVET19GVU5DKEJQRl9SRUdfMiwgOCksICAgICAgICAgLyogNS02OiByMiA9IGNh
bGxiYWNrIChpbnNuIDE0KSAqLw0KCQlCUEZfTU9WNjRfUkVHKEJQRl9SRUdfMywgQlBGX1JFR18x
MCksICAgICAvKiA3OiByMyA9IHIxMCAqLw0KCQlCUEZfQUxVNjRfSU1NKEJQRl9BREQsIEJQRl9S
RUdfMywgLTgpLCAgICAvKiA4OiByMyArPSAtOCAqLw0KCQlCUEZfU1RfTUVNKEJQRl9EVywgQlBG
X1JFR18xMCwgLTgsIDApLCAgICAvKiA5OiAqKHU2NCopKHIxMC04KSA9IDAgKi8NCgkJQlBGX01P
VjY0X0lNTShCUEZfUkVHXzQsIDEpLCAgICAgICAgICAgICAgLyogMTA6IHI0ID0gMSAoZmxhZ3Mp
ICovDQoJCUJQRl9DQUxMX0ZVTkMoQlBGX0ZVTkNfbG9vcCksICAgICAgICAgICAgIC8qIDExOiBy
MCA9IGJwZl9sb29wKC4uLikgKi8NCgkJQlBGX01PVjY0X0lNTShCUEZfUkVHXzAsIDEpLCAgICAg
ICAgICAgICAgLyogMTI6IHIwID0gMSAqLw0KCQlCUEZfRVhJVF9JTlNOKCksICAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiAxMzogZXhpdCAqLw0KDQoJCS8qIGNhbGxiYWNrICgxNC0yMCk6IHBy
ZWNpc2lvbiBjaGFpbiAqLw0KCQlCUEZfTU9WNjRfUkVHKEJQRl9SRUdfMiwgQlBGX1JFR18xKSwg
ICAgICAvKiAxNDogcjIgPSByMSAoaW5kZXgpICovDQoJCUJQRl9KTVBfSU1NKEJQRl9KRVEsIEJQ
Rl9SRUdfMiwgMSwgMyksICAgIC8qIDE1OiBpZiByMiA9PSAxIGdvdG8gKzMgKi8NCgkJQlBGX0FM
VTY0X0lNTShCUEZfQURELCBCUEZfUkVHXzIsIDEpLCAgICAgLyogMTY6IHIyICs9IDEgKi8NCgkJ
QlBGX0FMVTY0X0lNTShCUEZfQU5ELCBCUEZfUkVHXzIsIDcpLCAgICAgLyogMTc6IHIyICY9IDcg
Ki8NCgkJQlBGX1NUWF9NRU0oQlBGX0RXLCBCUEZfUkVHXzEwLCBCUEZfUkVHXzIsIC0xNiksIC8q
IDE4OiAqKHU2NCopKHIxMC0xNikgPSByMiAqLw0KCQlCUEZfTU9WNjRfSU1NKEJQRl9SRUdfMCwg
MSksICAgICAgICAgICAgICAvKiAxOTogcjAgPSAxICovDQoJCUJQRl9FWElUX0lOU04oKSwgICAg
ICAgICAgICAgICAgICAgICAgICAgIC8qIDIwOiBleGl0ICovDQoJfTsNCg0KCS8qIDMuIGxvYWQg
d2l0aCBmdW5jX2luZm8gKyB2ZXJpZmllciBsb2cgKGxldmVsIDIpICovDQoJdW5pb24gYnBmX2F0
dHIgYSA9IHt9Ow0KCWEucHJvZ190eXBlID0gQlBGX1BST0dfVFlQRV9TT0NLRVRfRklMVEVSOw0K
CWEuaW5zbl9jbnQgPSBzaXplb2YoaW5zbnMpIC8gc2l6ZW9mKGluc25zWzBdKTsNCglhLmluc25z
ID0gKHVpbnQ2NF90KSh1aW50cHRyX3QpaW5zbnM7DQoJYS5saWNlbnNlID0gKHVpbnQ2NF90KSh1
aW50cHRyX3QpIkdQTCI7DQoJYS5wcm9nX2J0Zl9mZCA9IGJ0Zl9mZDsNCglhLmZ1bmNfaW5mb19y
ZWNfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgYnBmX2Z1bmNfaW5mbyk7DQoJYS5mdW5jX2luZm9fY250
ID0gc2l6ZW9mKGZ1bmNfaW5mbykgLyBzaXplb2YoZnVuY19pbmZvWzBdKTsNCglhLmZ1bmNfaW5m
byA9ICh1aW50NjRfdCkodWludHB0cl90KWZ1bmNfaW5mbzsNCglhLmxvZ19sZXZlbCA9IDI7DQoJ
YS5sb2dfc2l6ZSA9IExPR19TSVpFOw0KCWEubG9nX2J1ZiA9ICh1aW50NjRfdCkodWludHB0cl90
KXZsb2c7DQoJdmxvZ1swXSA9IDA7DQoNCglpbnQgZmQgPSBzeXNfYnBmKEJQRl9QUk9HX0xPQUQs
ICZhKTsNCglwcmludGYoIkJQRl9QUk9HX0xPQUQgcmM9JWQgZXJybm89JWQgKCVzKVxuIiwgZmQs
IGZkIDwgMCA/IGVycm5vIDogMCwNCgkgICAgICAgZmQgPCAwID8gc3RyZXJyb3IoZXJybm8pIDog
IiIpOw0KDQoJLyogNC4gcmVwb3J0IGRldGVjdGlvbjogImJhY2t0cmFja2luZyBtaXN1c2UiIGlu
IHZlcmlmaWVyIGxvZyAqLw0KCXZsb2dbTE9HX1NJWkUgLSAxXSA9IDA7DQoJaW50IGhpdCA9IHN0
cnN0cih2bG9nLCAiYmFja3RyYWNraW5nIG1pc3VzZSIpICE9IE5VTEw7DQoJcHJpbnRmKCJ2ZXJp
ZmllciBsb2cgaGFzICdiYWNrdHJhY2tpbmcgbWlzdXNlJzogJXNcbiIsDQoJICAgICAgIGhpdCA/
ICJZRVMgKHRyaWdnZXJlZCkiIDogIm5vIik7DQoJaWYgKGhpdCkgew0KCQkvKiBwcmludCB0aGUg
bG9nIHJlZ2lvbiBhcm91bmQgdGhlIG1hcmtlciAqLw0KCQljb25zdCBjaGFyICpwID0gc3Ryc3Ry
KHZsb2csICJiYWNrdHJhY2tpbmcgbWlzdXNlIik7DQoJCWxvbmcgc3RhcnQgPSBwIC0gdmxvZzsN
CgkJbG9uZyBmcm9tID0gc3RhcnQgPiA0MDAgPyBzdGFydCAtIDQwMCA6IDA7DQoJCXByaW50Zigi
LS0tIHZlcmlmaWVyIGxvZyB0YWlsIGFyb3VuZCB0cmlnZ2VyIC0tLVxuIik7DQoJCXByaW50Zigi
JXNcbiIsIHZsb2cgKyBmcm9tKTsNCgl9IGVsc2Ugew0KCQkvKiBwcmludCBsYXN0IDEuNUtCIHNv
IGZhaWx1cmVzIGFyZSBkaWFnbm9zYWJsZSAqLw0KCQlsb25nIGxlbiA9IHN0cmxlbih2bG9nKTsN
CgkJbG9uZyBmcm9tID0gbGVuID4gMTUzNiA/IGxlbiAtIDE1MzYgOiAwOw0KCQlwcmludGYoIi0t
LSB2ZXJpZmllciBsb2cgdGFpbCAobGFzdCAxNTM2IGJ5dGVzKSAtLS1cbiIpOw0KCQlwcmludGYo
IiVzXG4iLCB2bG9nICsgZnJvbSk7DQoJfQ0KCXByaW50ZigiY2hlY2sgZG1lc2cgZm9yOiBXQVJO
SU5HOiAuLi4ga2VybmVsL2JwZi9iYWNrdHJhY2suYzo4MTlcbiIpOw0KCWNsb3NlKGJ0Zl9mZCk7
DQoJaWYgKGZkID49IDApDQoJCWNsb3NlKGZkKTsNCglyZXR1cm4gaGl0ID8gMCA6IDI7DQp9
--000000000000489f19065a17eea8--
