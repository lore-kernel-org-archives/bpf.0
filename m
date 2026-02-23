Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283F378D84
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884904; cv=none; b=JerpJYPkO50v3smYndUWOIsBfIz5ZvKqjPNwNZdFr5AVL7PneTUo7+fX9VaDP9Qvm27+qmP+ZicN/1OYnXg2MVjexhbCbTPT3lg3P/pF4Np4tZgoRp4tWyQ9Twque+eaRfOnvy/N3NHOG7jTRjAXoyzeafJoGU2lyeYzIgskdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884904; c=relaxed/simple;
	bh=NIfloqoIHGILusvHkncmOzyJvUhitou5tJ92AtIzHeI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Op6PrNzi9dBpafK8cLJ4ZcBQgjSxYkcmBOQu/cAQQJScMFG7Ltbio5czPkmRxQnzm9xDV70HS7wFp9uCH3i3afB5u2IFS9f2m07wXIag1DulX9o2u6ULNkGWU3PMB10eTu6rnIquLkyCaTPacN4D1RsSSbAI+cpBZnzDYf+tKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8fywv6T; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8fywv6T"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso5818006c88.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884902; x=1772489702; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s7OtEWr3bp/4rUR7xDgbO0CI7eE4cq8/LSgsx9wDy/s=;
        b=j8fywv6T0Eghrh0RPbVWuOI5q/vzRQ+5ZJbAsSOR2H7XHA3zO+QJ9uEUUHrsqjTKxY
         VXdXJoEQHKT5R1Sb/g0qM7d6Ba5of0ylIUE1pyUHpVPAnyX2B8j4UEgwKUnYHq/hisg9
         WYrTgukni4wz12RJZjd+TemHArjBA0z66QbUYviq5ViISagGyW4J6vhcVQZ0xQ9Vtq7U
         /PsSCTqv7k3+1oAuFth99TPLbJfKeZNmVBR2Ob1wmXrq9/2/16AhP7sTxm22Ga01Vxaz
         zmSAPHXOB/6/UpCpHJJ7qapHGeogwAet9QkdA2Hi2VlACvSm+Pd3iSui1M97qYYxAXAz
         rYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884902; x=1772489702;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7OtEWr3bp/4rUR7xDgbO0CI7eE4cq8/LSgsx9wDy/s=;
        b=EfXx9KUWPIvpx21H4Asj6HFrQLuRKhnvwwCgXTLG+V1ik+B0uc54pI5tNBvfFYyD0W
         IB2CVvTpshBgNNUmWg7K5IuLhIcNJBSe/bhP2KOiww9UbBkcyn22cybXVrAcqMtI8Ejr
         H8NZB7arYLJcRr+n1jUlMMqfYXGbO7Q0P/gFdggchE8c0n/pwitrZnPckrhxrLtYtNL6
         Jjzafd0+nY6XVUyjQJroLTOf2TmIAlSFv+b06Mw9XucXYw/8Y1FBY9McTDtFt2JpfDqd
         5ta2skZfgqZrzRYxtqk3gam8B0oo2COuV7nTFKPzqP6FIUjGaytNPj6CYmDCmicyQ18V
         J45A==
X-Forwarded-Encrypted: i=1; AJvYcCWWhIhlw+iHMIhzFhWwrfBkkjn26eHXYUzzf6Q/Wxz+Lxycf7AYzS3XRWlg/gPrx/ATOm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMW8az9m0NSbcwHK3praxmc9M/db/fI6vivKJQBp8zGTyHrnuE
	C2bYjZYcWcmkxnyJ/OfGjIrV614+6TsluPl4qfkCAmg4Vw4EYLArtcGs
X-Gm-Gg: AZuq6aLhlUHmriZG/QYmMO+p1KxnN5sdvt3fvrYLoUOU1MtLN+3AzmBapl6lDXN0a1y
	0CBh5kVfPQzzKquvHLcsVFpN8AwHL7u9DphdVY5lSA3DwF+mXFtQbiEoa4/yliTOfjlKx5esf8B
	rUeKPLxuetWrA9srBd4c/evrk5FaM66CjVDHHbmlUlMB6zYkvNKvVAEaPH/M2xjHk9jxmWPCRZu
	tWwpes/GSRY99DTRPs3vycr+hRo3rXy0NxnFNNZYU3kEvPrq4D2QYpf7i/QAvG6AkQH391eG3E6
	8M9LkEY7C3qFbxVyBRNsO8pnKJBg3m1Koaka84fp9MHM+ak0gfKsJXKzlcCBj/0RumXBaLkS3JV
	bLTmdEc54lTlf9ApNycp6moMF5w3ZlTw0bJLe6FjMKbQThSof3dl0pQuBRcNOwR62wAcvappBYf
	eWUHdKOyDLbTNn7Dh207s0mRjg+/wzO96d3LI49h6vR3YoeKacyiG+QBzl7x3Quz6RUm/vvyB8Q
	C9Bt4oL4QOBucQtz30=
X-Received: by 2002:a05:7022:f9e:b0:127:5c57:cffc with SMTP id a92af1059eb24-1276ad18534mr3788063c88.26.1771884901987;
        Mon, 23 Feb 2026 14:15:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7b4c7sm8915171c88.9.2026.02.23.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:15:01 -0800 (PST)
Message-ID: <562fc6aeef17412ba8965bc4938fe9c0dbbe0f9e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Mon, 23 Feb 2026 14:14:59 -0800
In-Reply-To: <20260223174659.2749964-4-puranjay@kernel.org>
References: <20260223174659.2749964-1-puranjay@kernel.org>
	 <20260223174659.2749964-4-puranjay@kernel.org>
Content-Type: multipart/mixed; boundary="=-0jUP7s9Y9U4w+NXx40eU"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-0jUP7s9Y9U4w+NXx40eU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-02-23 at 09:46 -0800, Puranjay Mohan wrote:

[...]

Would it be possible to move regular spin locks to similar semantics
(reference forbidding sleep)?

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..65327d2f19c1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8644,6 +8644,9 @@ static int btf_check_kfunc_protos(struct btf *btf, =
u32 func_id, u32 func_flags)
>  			return err;
>  	}
> =20
> +	if ((func_flags & KF_FORBID_SLEEP) && !(func_flags & KF_ACQUIRE))
> +		return -EINVAL;
> +

Are you sure this check is necessary?

>  	return 0;
>  }
> =20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c2a63f8c8984..a90c3d1b2d72 100644

[...]

> @@ -14214,6 +14228,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		return -EACCES;
>  	}
> =20
> +	if (sleepable && env->cur_state->forbid_sleep_count) {
> +		verbose(env, "sleepable kfunc %s in nosleep region\n", func_name);
> +		return -EACCES;
> +	}
> +

Instead of adding this hunk please do the following:
- add a refactoring patch as in the attachment;
- remove the following check from do_check_insn():

  >   if (env->cur_state->active_locks) {
  >       if ((insn->src_reg =3D=3D BPF_REG_0 &&
  >            insn->imm !=3D BPF_FUNC_spin_unlock) ||
  >           (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
  >            (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
  >           verbose(env,
  >               "function calls are not allowed while holding a lock\n");
  >           return -EINVAL;
  >       }
  >   }

  Relying instead on `sleepable && !in_sleepable_context()` checks in
  check_kfunc_call() and check_helper_call(). (As one more refactoring patc=
h).

[...]

--=-0jUP7s9Y9U4w+NXx40eU
Content-Disposition: attachment; filename="check-kfunc-call.diff"
Content-Type: text/x-patch; name="check-kfunc-call.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIu
YwppbmRleCAyZWYwMGY5Yjk0ZmUuLjRhNWQ3NDJmZTRhNCAxMDA2NDQKLS0tIGEva2VybmVsL2Jw
Zi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwpAQCAtMTQxNTMsMzQgKzE0
MTY2LDIyIEBAIHN0YXRpYyBpbnQgY2hlY2tfa2Z1bmNfY2FsbChzdHJ1Y3QgYnBmX3ZlcmlmaWVy
X2VudiAqZW52LCBzdHJ1Y3QgYnBmX2luc24gKmluc24sCiAJCQkJfQogCQkJfSkpOwogCQl9Ci0J
fSBlbHNlIGlmIChzbGVlcGFibGUgJiYgZW52LT5jdXJfc3RhdGUtPmFjdGl2ZV9yY3VfbG9ja3Mp
IHsKLQkJdmVyYm9zZShlbnYsICJrZXJuZWwgZnVuYyAlcyBpcyBzbGVlcGFibGUgd2l0aGluIHJj
dV9yZWFkX2xvY2sgcmVnaW9uXG4iLCBmdW5jX25hbWUpOwotCQlyZXR1cm4gLUVBQ0NFUzsKLQl9
Ci0KLQlpZiAoaW5fcmJ0cmVlX2xvY2tfcmVxdWlyZWRfY2IoZW52KSAmJiAocmN1X2xvY2sgfHwg
cmN1X3VubG9jaykpIHsKLQkJdmVyYm9zZShlbnYsICJDYWxsaW5nIGJwZl9yY3VfcmVhZF97bG9j
ayx1bmxvY2t9IGluIHVubmVjZXNzYXJ5IHJidHJlZSBjYWxsYmFja1xuIik7Ci0JCXJldHVybiAt
RUFDQ0VTOwotCX0KLQotCWlmIChlbnYtPmN1cl9zdGF0ZS0+YWN0aXZlX3ByZWVtcHRfbG9ja3Mp
IHsKLQkJaWYgKHByZWVtcHRfZGlzYWJsZSkgewotCQkJZW52LT5jdXJfc3RhdGUtPmFjdGl2ZV9w
cmVlbXB0X2xvY2tzKys7Ci0JCX0gZWxzZSBpZiAocHJlZW1wdF9lbmFibGUpIHsKLQkJCWVudi0+
Y3VyX3N0YXRlLT5hY3RpdmVfcHJlZW1wdF9sb2Nrcy0tOwotCQl9IGVsc2UgaWYgKHNsZWVwYWJs
ZSkgewotCQkJdmVyYm9zZShlbnYsICJrZXJuZWwgZnVuYyAlcyBpcyBzbGVlcGFibGUgd2l0aGlu
IG5vbi1wcmVlbXB0aWJsZSByZWdpb25cbiIsIGZ1bmNfbmFtZSk7Ci0JCQlyZXR1cm4gLUVBQ0NF
UzsKLQkJfQogCX0gZWxzZSBpZiAocHJlZW1wdF9kaXNhYmxlKSB7CiAJCWVudi0+Y3VyX3N0YXRl
LT5hY3RpdmVfcHJlZW1wdF9sb2NrcysrOwogCX0gZWxzZSBpZiAocHJlZW1wdF9lbmFibGUpIHsK
LQkJdmVyYm9zZShlbnYsICJ1bm1hdGNoZWQgYXR0ZW1wdCB0byBlbmFibGUgcHJlZW1wdGlvbiAo
a2VybmVsIGZ1bmN0aW9uICVzKVxuIiwgZnVuY19uYW1lKTsKLQkJcmV0dXJuIC1FSU5WQUw7CisJ
CWlmIChlbnYtPmN1cl9zdGF0ZS0+YWN0aXZlX3ByZWVtcHRfbG9ja3MgPT0gMCkgeworCQkJdmVy
Ym9zZShlbnYsICJ1bm1hdGNoZWQgYXR0ZW1wdCB0byBlbmFibGUgcHJlZW1wdGlvbiAoa2VybmVs
IGZ1bmN0aW9uICVzKVxuIiwgZnVuY19uYW1lKTsKKwkJCXJldHVybiAtRUlOVkFMOworCQl9CisJ
CWVudi0+Y3VyX3N0YXRlLT5hY3RpdmVfcHJlZW1wdF9sb2Nrcy0tOworCX0gZWxzZSBpZiAoc2xl
ZXBhYmxlICYmICFpbl9zbGVlcGFibGVfY29udGV4dChlbnYpKSB7CisJCXZlcmJvc2UoZW52LCAi
a2VybmVsIGZ1bmMgJXMgaXMgc2xlZXBhYmxlIHdpdGhpbiAlc1xuIiwKKwkJCWZ1bmNfbmFtZSwg
bm9uX3NsZWVwYWJsZV9jb250ZXh0X2Rlc2NyaXB0aW9uKGVudikpOworCQlyZXR1cm4gLUVBQ0NF
UzsKIAl9CiAKLQlpZiAoZW52LT5jdXJfc3RhdGUtPmFjdGl2ZV9pcnFfaWQgJiYgc2xlZXBhYmxl
KSB7Ci0JCXZlcmJvc2UoZW52LCAia2VybmVsIGZ1bmMgJXMgaXMgc2xlZXBhYmxlIHdpdGhpbiBJ
UlEtZGlzYWJsZWQgcmVnaW9uXG4iLCBmdW5jX25hbWUpOworCWlmIChpbl9yYnRyZWVfbG9ja19y
ZXF1aXJlZF9jYihlbnYpICYmIChyY3VfbG9jayB8fCByY3VfdW5sb2NrKSkgeworCQl2ZXJib3Nl
KGVudiwgIkNhbGxpbmcgYnBmX3JjdV9yZWFkX3tsb2NrLHVubG9ja30gaW4gdW5uZWNlc3Nhcnkg
cmJ0cmVlIGNhbGxiYWNrXG4iKTsKIAkJcmV0dXJuIC1FQUNDRVM7CiAJfQogCg==


--=-0jUP7s9Y9U4w+NXx40eU--
