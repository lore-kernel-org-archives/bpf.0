Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22130CD85
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750626; cv=none; b=r3xc+9LxDRuQoCuiMRy7NL3nZHFF5HZESQMZPVHlY92+TXH/xZvSbKyi/MeEDguwrD51ZYuxPecfJ3lahDaqzqLxH+ucb/dO28GZQhOg169R5yioyL5u6HzAmnOh3pqJ3YDpGFmOuNu/jLhdkGK4FpOerNXtMCBloirfUc5WC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750626; c=relaxed/simple;
	bh=oLfiG+sja5PliVS+TQ0gIVVVZQ6wZH0KZ71olhDGV4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVTQEYcxqH91e96GIk2Trn2hhXWMAbKg/+QriR9niNw6C5eIRcoMVQQSnbPmjiWbVf++kS15mOSBaDs9bagZPy/r0HcN/bTmnAM567vOX8fRWqZh38cWL7YE7BYXBU06sCB5RYGp94JaNNJP1c1P1woahvVfGxRbK5OXYp8gMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5sKjiga; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5sKjiga"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d02b4c3601so18929295ad.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786750625; x=1787355425; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PrALtt3WRlI5TPm9uwQqTcTVlz1wgxBJMnHna3xxnQA=;
        b=Q5sKjigan5xKOY6JG5HdTj0WUgIAgxqzQkaqVhKgnAljYX5N+tq1mSR00W3344EqKi
         0t32DTGzfqRNn4sg3Cqp1MvRfiPDdJQimAx3KlF9DK6gRnGixHkMZPWkymtK6+/Y/hXK
         kZg287vI/3d1ivYj3Y0F6oX4q22HrPDNRr2Jkdfw+fPAsmty+xYlD1O2DYmixCINWk9n
         JaQp2vSk2zyqG8mHXt0VrDfXmf/0a1XJPQKD0YxYd3wBG/8TI2lW3OH4Vble3HFTRsbM
         AAYszC1tOm8nVWylTvuhcrc8/rMeiEBlZHukilJ9F8whugZfHhkHUnkwl3Ap9KnXszT4
         1ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786750625; x=1787355425;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PrALtt3WRlI5TPm9uwQqTcTVlz1wgxBJMnHna3xxnQA=;
        b=QdVLTct0aBoaWZE99Ad6/pI0GBeYdMWPt1bLyKinIafh7z388MNSyxxvIzGGK4XSUp
         8uR/3SIpD4QntMIy8+tbWLlpeA0k9DWPH2sJKBp3H9oz4timpKJq+tmMC73R5WiT8H9Q
         As6k5b3RPJB/WI+4hRSRD/crSDz90KX0aRnOnorNVZ4sfo+alB3ef7GrwhXFBAvlcOTG
         yMomY8cICt2PHJS6gZD/D313cG3KQufyC/5ShcS/C8zBlRmUckpchmRh3iMaNDAKGg85
         3ioGHd0vkWpTtPzk+zgh3PxiT261amA/AT3NcYnQXmtcPqA2HV0UZqJOXB8Mq1ctIrHt
         ty7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqxtyd7zCjDWzl82ZWOF14TsAqarsZQfl0/oAKjzdV02YIOWoEmWTZu8kXgayb8N8GZGEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbxz/LjNK+BMEqIU/M+UhYwjWVSe92Oyx3EPgi6JHK7aLd5Qho
	JmcdoWBTJR5+C+7EH8X+tJGMwSLm6YO5B/yUpoa9erZNBfWLAu/Cv8es
X-Gm-Gg: AR+sD13nsqj0iKAnL0qjUxvirLoVt6MIAoqPEwvoQCTlLgb0wiJNe8yDmScISzR8GGj
	5lvLFwaWkBLTSueaIPkfbdxBYEGgIdqHIDvU4/tVUV/HmTyEANyu1DAz5mcW+p8rXTfdk+hurvA
	MMQ8Yvh16aD0p78VfDVBZDqu5Bmnu77g3ofcOiCZA1AgMhp1Si7alY63GhhMYmvfqhBfhDBbJTn
	1+0rb4cgZsMnDjSXUmZONdGIRXQckbERcDGkNEF7mu2mAo/PjkINW5uH12Pc3klq8R99XlrLUnC
	ZCTsxiI0iVTEGEdBH2/+i/tk2nQmhHL4XdZdO4hGckDI5hWDr3Mfcq/K9SMLrgbH07Vw8fhhTeO
	xh0qeZa1LrG5tXJ8RzYXrH7RxMpQEg+5n59TWCN8QqfvFD90iIujZwkWHaGTP09M7OGNRQKag10
	N/tvunh/kpjt0KJY/6FPBVS0Czn53lItXihV0qH/5WIYs40MM95dd8ghsPsINrhPaQ37JzKyWr8
	+8w0voHLN9sfV31JKcRsB70xDCAitbWZtG/cpyYs3bk
X-Received: by 2002:a17:903:160c:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2d3b0827ff2mr110259775ad.5.1786750624538;
        Fri, 14 Aug 2026 16:37:04 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d61e1568sm8727785eec.11.2026.08.14.16.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 16:37:03 -0700 (PDT)
Message-ID: <206e8cd41f7955e6526b78df4f9bfd2307b13260.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 04/11] bpf: Track R2 of register-pair
 returns in precision backtracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 14 Aug 2026 16:37:02 -0700
In-Reply-To: <20260813200230.1995389-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
	 <20260813200230.1995389-1-yonghong.song@linux.dev>
Content-Type: multipart/mixed; boundary="=-MzDcU1QfuFLPQ4rwrxF8"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-MzDcU1QfuFLPQ4rwrxF8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:

...

> @@ -520,7 +541,41 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
>  		} else if (opcode =3D=3D BPF_EXIT) {
> -			bool r0_precise;
> +			bool from_subprog_call, r0_precise, r2_precise;
> +			struct bpf_insn *call;
> +			int subprog;
> +
> +			/* BPF_EXIT in subprog or callback always returns
> +			 * right after the call instruction, so by checking
> +			 * whether the instruction at subseq_idx-1 is subprog
> +			 * call or not we can distinguish actual exit from
> +			 * *subprog* from exit from *callback*. In the former
> +			 * case, we need to propagate the precision of the
> +			 * return registers, if necessary. In the latter we
> +			 * never do that.
> +			 */
> +			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
> +					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
> +
> +			/* Sample the return registers before the callback
> +			 * handling below clears R1-R5: unlike R0, R2 is an
> +			 * argument register as well, so that clear would drop
> +			 * a pair return on the floor.
> +			 */
> +			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
> +			r2_precise =3D false;
> +			if (from_subprog_call && bt_is_reg_set(bt, BPF_REG_2)) {
> +				call =3D &env->prog->insnsi[subseq_idx - 1];
> +				subprog =3D bpf_find_subprog(env, subseq_idx + call->imm);
> +				if (subprog < 0)
> +					return -EFAULT;
> +				/* Only a callee that does return a pair defines
> +				 * R2. Leave the mask alone otherwise, so that
> +				 * the check below still catches an R2 that has
> +				 * no business being set.
> +				 */
> +				r2_precise =3D bpf_ret_reg_pair(env, subprog);
> +			}
> =20
>  			/* Backtracking to a nested function call, 'idx' is a part of
>  			 * the inner frame 'subseq_idx' is a part of the outer frame.

I still think that the above complications are unnecessary.
The patch could be simplified by assuming that R2 always propagates
w/o loosing verification safety. E.g. as in the attachment.

--=-MzDcU1QfuFLPQ4rwrxF8
Content-Disposition: attachment; filename="backtracking.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="backtracking.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvYmFja3RyYWNrLmMgYi9rZXJuZWwvYnBmL2JhY2t0cmFj
ay5jCmluZGV4IGEyYjE4YTlmMTY5NC4uOThiZjU5ZDdhZTU2IDEwMDY0NAotLS0gYS9rZXJuZWwv
YnBmL2JhY2t0cmFjay5jCisrKyBiL2tlcm5lbC9icGYvYmFja3RyYWNrLmMKQEAgLTQyMyw2ICs0
MjMsMTAgQEAgc3RhdGljIGludCBiYWNrdHJhY2tfaW5zbihzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2Vu
diAqZW52LCBpbnQgaWR4LCBpbnQgc3Vic2VxX2lkeCwKIAkJCQkgKi8KIAkJCQl2ZXJpZmllcl9i
dWdfaWYoaWR4ICsgMSAhPSBzdWJzZXFfaWR4LCBlbnYsCiAJCQkJCQkiZXh0cmEgaW5zbiBmcm9t
IHN1YnByb2ciKTsKKwkJCQkvKiBnbG9iYWwgc3VicHJvZyBhbHdheXMgc2V0cyBSMCAqLworCQkJ
CWJ0X2NsZWFyX3JlZyhidCwgQlBGX1JFR18wKTsKKwkJCQkvKiBhbmQgaWYgaXQgZG9lcyBub3Qg
c2V0IFIyLCBtYWluIHBhc3Mgd291bGQgY2F0Y2ggaXQgKi8KKwkJCQlidF9jbGVhcl9yZWcoYnQs
IEJQRl9SRUdfMik7CiAJCQkJLyogcjEtcjUgYXJlIGludmFsaWRhdGVkIGFmdGVyIHN1YnByb2cg
Y2FsbCwKIAkJCQkgKiBzbyBmb3IgZ2xvYmFsIGZ1bmMgY2FsbCBpdCBzaG91bGRuJ3QgYmUgc2V0
CiAJCQkJICogYW55bW9yZQpAQCAtNDMyLDggKzQzNiw2IEBAIHN0YXRpYyBpbnQgYmFja3RyYWNr
X2luc24oc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGlkeCwgaW50IHN1YnNlcV9p
ZHgsCiAJCQkJCQkgICAgIGJ0X3JlZ19tYXNrKGJ0KSk7CiAJCQkJCXJldHVybiAtRUZBVUxUOwog
CQkJCX0KLQkJCQkvKiBnbG9iYWwgc3VicHJvZyBhbHdheXMgc2V0cyBSMCAqLwotCQkJCWJ0X2Ns
ZWFyX3JlZyhidCwgQlBGX1JFR18wKTsKIAkJCQlyZXR1cm4gMDsKIAkJCX0gZWxzZSB7CiAJCQkJ
Lyogc3RhdGljIHN1YnByb2cgY2FsbCBpbnN0cnVjdGlvbiwgd2hpY2gKQEAgLTUwNiw2ICs1MDgs
OCBAQCBzdGF0aWMgaW50IGJhY2t0cmFja19pbnNuKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICpl
bnYsIGludCBpZHgsIGludCBzdWJzZXFfaWR4LAogCQkJCXJldHVybiAtRU5PVFNVUFA7CiAJCQkv
KiByZWd1bGFyIGhlbHBlciBjYWxsIHNldHMgUjAgKi8KIAkJCWJ0X2NsZWFyX3JlZyhidCwgQlBG
X1JFR18wKTsKKwkJCS8qIGtmdW5jIG1pZ2h0IGFzbG8gc2V0IFIyICovCisJCQlidF9jbGVhcl9y
ZWcoYnQsIEJQRl9SRUdfMik7CiAJCQlpZiAoYnRfcmVnX21hc2soYnQpICYgQlBGX1JFR01BU0tf
QVJHUykgewogCQkJCS8qIGlmIGJhY2t0cmFja2luZyB3YXMgbG9va2luZyBmb3IgcmVnaXN0ZXJz
IFIxLVI1CiAJCQkJICogdGhleSBzaG91bGQgaGF2ZSBiZWVuIGZvdW5kIGFscmVhZHkuCkBAIC01
MjAsNyArNTI0LDI1IEBAIHN0YXRpYyBpbnQgYmFja3RyYWNrX2luc24oc3RydWN0IGJwZl92ZXJp
Zmllcl9lbnYgKmVudiwgaW50IGlkeCwgaW50IHN1YnNlcV9pZHgsCiAJCQkJCXJldHVybiAtRUZB
VUxUOwogCQkJfQogCQl9IGVsc2UgaWYgKG9wY29kZSA9PSBCUEZfRVhJVCkgewotCQkJYm9vbCBy
MF9wcmVjaXNlOworCQkJYm9vbCBmcm9tX3N1YnByb2dfY2FsbCwgcjBfcHJlY2lzZSwgcjJfcHJl
Y2lzZTsKKworCQkJLyogQlBGX0VYSVQgaW4gc3VicHJvZyBvciBjYWxsYmFjayBhbHdheXMgcmV0
dXJucworCQkJICogcmlnaHQgYWZ0ZXIgdGhlIGNhbGwgaW5zdHJ1Y3Rpb24sIHNvIGJ5IGNoZWNr
aW5nCisJCQkgKiB3aGV0aGVyIHRoZSBpbnN0cnVjdGlvbiBhdCBzdWJzZXFfaWR4LTEgaXMgc3Vi
cHJvZworCQkJICogY2FsbCBvciBub3Qgd2UgY2FuIGRpc3Rpbmd1aXNoIGFjdHVhbCBleGl0IGZy
b20KKwkJCSAqICpzdWJwcm9nKiBmcm9tIGV4aXQgZnJvbSAqY2FsbGJhY2sqLiBJbiB0aGUgZm9y
bWVyCisJCQkgKiBjYXNlLCB3ZSBuZWVkIHRvIHByb3BhZ2F0ZSB0aGUgcHJlY2lzaW9uIG9mIHRo
ZQorCQkJICogcmV0dXJuIHJlZ2lzdGVycywgaWYgbmVjZXNzYXJ5LiBJbiB0aGUgbGF0dGVyIHdl
CisJCQkgKiBuZXZlciBkbyB0aGF0LgorCQkJICovCisJCQlmcm9tX3N1YnByb2dfY2FsbCA9IHN1
YnNlcV9pZHggLSAxID49IDAgJiYKKwkJCQkJICAgIGJwZl9wc2V1ZG9fY2FsbCgmZW52LT5wcm9n
LT5pbnNuc2lbc3Vic2VxX2lkeCAtIDFdKTsKKworCQkJLyogU2FtcGxlIHRoZSByZXR1cm4gcmVn
aXN0ZXJzIGJlZm9yZSB0aGUgY2FsbGJhY2sKKwkJCSAqIGhhbmRsaW5nIGJlbG93IGNsZWFycyBS
MS1SNS4KKwkJCSAqLworCQkJcjBfcHJlY2lzZSA9IGZyb21fc3VicHJvZ19jYWxsICYmIGJ0X2lz
X3JlZ19zZXQoYnQsIEJQRl9SRUdfMCk7CisJCQlyMl9wcmVjaXNlID0gZnJvbV9zdWJwcm9nX2Nh
bGwgJiYgYnRfaXNfcmVnX3NldChidCwgQlBGX1JFR18yKTsKIAogCQkJLyogQmFja3RyYWNraW5n
IHRvIGEgbmVzdGVkIGZ1bmN0aW9uIGNhbGwsICdpZHgnIGlzIGEgcGFydCBvZgogCQkJICogdGhl
IGlubmVyIGZyYW1lICdzdWJzZXFfaWR4JyBpcyBhIHBhcnQgb2YgdGhlIG91dGVyIGZyYW1lLgpA
QCAtNTMzLDMwICs1NTUsMjIgQEAgc3RhdGljIGludCBiYWNrdHJhY2tfaW5zbihzdHJ1Y3QgYnBm
X3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgaWR4LCBpbnQgc3Vic2VxX2lkeCwKIAkJCWlmIChzdWJz
ZXFfaWR4ID49IDAgJiYgYnBmX2NhbGxzX2NhbGxiYWNrKGVudiwgc3Vic2VxX2lkeCkpCiAJCQkJ
Zm9yIChpID0gQlBGX1JFR18xOyBpIDw9IEJQRl9SRUdfNTsgaSsrKQogCQkJCQlidF9jbGVhcl9y
ZWcoYnQsIGkpOworCisJCQlidF9jbGVhcl9yZWcoYnQsIEJQRl9SRUdfMCk7CisJCQlidF9jbGVh
cl9yZWcoYnQsIEJQRl9SRUdfMik7CiAJCQlpZiAoYnRfcmVnX21hc2soYnQpICYgQlBGX1JFR01B
U0tfQVJHUykgewogCQkJCXZlcmlmaWVyX2J1ZyhlbnYsICJiYWNrdHJhY2tpbmcgZXhpdCB1bmV4
cGVjdGVkIHJlZ3MgJXgiLAogCQkJCQkgICAgIGJ0X3JlZ19tYXNrKGJ0KSk7CiAJCQkJcmV0dXJu
IC1FRkFVTFQ7CiAJCQl9CiAKLQkJCS8qIEJQRl9FWElUIGluIHN1YnByb2cgb3IgY2FsbGJhY2sg
YWx3YXlzIHJldHVybnMKLQkJCSAqIHJpZ2h0IGFmdGVyIHRoZSBjYWxsIGluc3RydWN0aW9uLCBz
byBieSBjaGVja2luZwotCQkJICogd2hldGhlciB0aGUgaW5zdHJ1Y3Rpb24gYXQgc3Vic2VxX2lk
eC0xIGlzIHN1YnByb2cKLQkJCSAqIGNhbGwgb3Igbm90IHdlIGNhbiBkaXN0aW5ndWlzaCBhY3R1
YWwgZXhpdCBmcm9tCi0JCQkgKiAqc3VicHJvZyogZnJvbSBleGl0IGZyb20gKmNhbGxiYWNrKi4g
SW4gdGhlIGZvcm1lcgotCQkJICogY2FzZSwgd2UgbmVlZCB0byBwcm9wYWdhdGUgcjAgcHJlY2lz
aW9uLCBpZgotCQkJICogbmVjZXNzYXJ5LiBJbiB0aGUgZm9ybWVyIHdlIG5ldmVyIGRvIHRoYXQu
Ci0JCQkgKi8KLQkJCXIwX3ByZWNpc2UgPSBzdWJzZXFfaWR4IC0gMSA+PSAwICYmCi0JCQkJICAg
ICBicGZfcHNldWRvX2NhbGwoJmVudi0+cHJvZy0+aW5zbnNpW3N1YnNlcV9pZHggLSAxXSkgJiYK
LQkJCQkgICAgIGJ0X2lzX3JlZ19zZXQoYnQsIEJQRl9SRUdfMCk7Ci0KLQkJCWJ0X2NsZWFyX3Jl
ZyhidCwgQlBGX1JFR18wKTsKIAkJCWlmIChidF9zdWJwcm9nX2VudGVyKGJ0KSkKIAkJCQlyZXR1
cm4gLUVGQVVMVDsKIAogCQkJaWYgKHIwX3ByZWNpc2UpCiAJCQkJYnRfc2V0X3JlZyhidCwgQlBG
X1JFR18wKTsKKwkJCWlmIChyMl9wcmVjaXNlKQorCQkJCWJ0X3NldF9yZWcoYnQsIEJQRl9SRUdf
Mik7CiAJCQkvKiByNi1yOSBhbmQgc3RhY2sgc2xvdHMgd2lsbCBzdGF5IHNldCBpbiBjYWxsZXIg
ZnJhbWUKIAkJCSAqIGJpdG1hc2tzIHVudGlsIHdlIHJldHVybiBiYWNrIGZyb20gY2FsbGVlKHMp
CiAJCQkgKi8K


--=-MzDcU1QfuFLPQ4rwrxF8--
