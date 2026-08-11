Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411D40F72B
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466959; cv=pass; b=cUqR2NUuOHIqYtnU3jcwK6JOeJ/iY0ynh6bnqO+qMFArlGX/2u71GpMyZsd8oMJ6MKqtE9k3nh4SSL5Hfk9ABlSwMMTPAfkzeFf5qTFgTFPLVR4tzNMEsvA3t1Q4NnyxmrKN4NNeHYaFWPT7dmM3tVoTA6vybHKY8n7uYcjHzYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466959; c=relaxed/simple;
	bh=m/7J770cldN0523WwrnaaO+ITaNtf/hGFf1kGkuVS0Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bL5n7uNDXPx2Pspv0NeRRQGSWA++WGitr0D+lQsnlXUT3G2MEQbCZ0O7ENsb62zWr870T91xLHcBgtOC+Ob9C67MBaU+u+18o0A/AFcJKfIXqj0OTahlXjEQouQBKnV3DeWBV5ZaKZd8j4KkGJjWK24h+IpwyWqkdJ4noEa/WD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rciqde0I; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rciqde0I"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso23511e87.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786466956; cv=none;
        d=google.com; s=arc-20260327;
        b=KYvBl+CNMlldyALIMr056pxVym9NnfqtgT/3aOi3JFLaFXSNUBZXi35z8vZxSeCBj+
         6yOEHQu7Iy0QL0tL7IRc2RI1uHlmIPXXfQQvM/tyR/gpsYlifqOXW+bbF/mPRXHQuzEX
         gJRw/0MsHenBJWFCFhd1CXLyP1Ay3+XLesSqyVYEi4+Bb3Vxqu/6Qxj8CHaK5S47Vjrh
         p7463hlCcogvq/L8LNGC/zthG8AsLNW7rKAtUmYgeyxBsWPKW6ZUoGshs/V0g5VAXHf6
         dcfJo/fjPX9Z1Ssd/1oxs3CPpJBxsfrYHAgKFe+w0CgnsaqTjL7yuy8853429+BsYzGV
         GDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FNL9wS13wpBLSk5IXIQsMQt/7pY53PnqP7s4P+/cQIU=;
        fh=KepTD2eORxmjIWP3EGUAsPZWmV+isJOHCQYVTLjfXsk=;
        b=g8r3mk4kapgdaBDdKeXVwzbgaTb5NG69wN9DVukAVzx4994kkGpyn9Gtobpp+jld5U
         TDpOqxuEOWRKnvzftpaxYnHRr/vdBpBJMzoWI6vuTFbKNOQASfy73KqCIf04jM23zWnw
         ocYSBp17gHcw7py0ITzAZXwt44qWoKhxFYmRxIjPIUpjamuqtJ+4qSK7pPWsuFb0eJ77
         va7m+ZfGz/HIu5jmrOkva6qNB5xCbCQfT8fV4d0QufPfoqgbgLv3zFQ8AjUVqsyOPH/q
         WmkRxO2Ne/PAFU4hUrg3tWFUcVl3R9uY+Mw7qZY/sxjFPAgWK6nmAsMXHef4GM3e4I4w
         7OGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786466956; x=1787071756; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FNL9wS13wpBLSk5IXIQsMQt/7pY53PnqP7s4P+/cQIU=;
        b=Rciqde0IIJz39jf1P9MtAPRplEpTnn/y4TLKCUk7yIa1g1MAD42kZgAbzrrOa2wNok
         Pq5bDXBdJPs+9TVURa3H1afIbURBtSJ7h+ijFfI4XvX6+Kr5jwt/gzR4XBCU4rpFDHbA
         Q2n7f/SZegItGEEWSs0foL6d+Tl/e6wRuLmxUBoVe0ZzrxQtM8fXKnDBgZuPoYexVNhK
         irVgnfrDqr4yyInzMIUEraOIyY22QnV1Q9P47bSn4+cSR0DEAh4jyPvXIX/BwBNK7u+8
         mg2mE7G5yzflcxj0AYLVIacvsXJh/VcCl5lokynVm+Kg1SEHPy4WvPx9r/iEKaw6B50k
         6N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466956; x=1787071756;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FNL9wS13wpBLSk5IXIQsMQt/7pY53PnqP7s4P+/cQIU=;
        b=B3L+WNwi3YRYgPgys+6ukt7lQpuRDLtOyP45ueIITqeYC37LkPRDbMMPCDmpBniquJ
         ZeQz2bD75QBocF+m/s2riZnyuh9bzA4YQuvsG/qARM112aybY48SVQ5kZqW17sm43jTa
         07pGxJMjRdeMdQQ/F63mgbgBQhBJtmswNmki6tF76iD67EYSwcDE69ooMGpsCMQpIEE/
         ANnDk9p5ERw4BIZ95LIzajFli8rnj08DqPrTE9TcfzuE1k59gA1hGEgLLaIXOKcSH0vA
         pniPabQ6mkhpu42+uAfOu6WJXWeMnbrg7g94Ac6HkxZLcM+9VzKA72eUi596Vdhn/9kF
         N06Q==
X-Gm-Message-State: AOJu0YzRwv0HgWOEAH9WD/xq7bnyWD3AKAB8js/i678hLp06gqjfU9qI
	q3ZOZ9HeNKWxv9WIdfPDGcoY1tQ+FStqxTcK62Q7jgcR1a7ZhZSQQgyCIAN0mJWWgNO2EyVPBCM
	qR28BQNKKsI0vA7rHbNDjaRnYR3MDDyLLmSfcuePqtQ==
X-Gm-Gg: AR+sD12FCrTYqp41aqhZ2j/J5Ami+arTsmYyj8RFzJCwEiirAQBqogSVjI2RcUihgvw
	+DkjqbtB8l9f8XorN8kZoh+pBiLzL0o27TlQDh4lVWkH77/u+4jNMOfwRD0cS+4SKP1bXseW97t
	WrToSXg2N3MPA4ftBycascu5dhwqPtxY5jrECNaoi3apbItttiAPyEgLIddN3BzPxlanBO+1k3m
	drH0A9V6e9NhdULyEO6ydZKNunHU0cvRymvApZjRJ8kTqHWnnB01l62CPF/jrzo8EqnEPDuqNWK
	iFwkY5Ib7CIcXXsGiENdj3hUFpqGLD5Db1pxHnw0Dc2Ky70D1WanIIIaNX/eU9Vq+YGHor2Movr
	iR2V3IJJOkBb0JuyQtDdMLC8xYK6LwHQ1R0lVH+dYUpDiBT6OI6MODpR+M7Q=
X-Received: by 2002:a05:6512:33c8:b0:5ae:ba28:a56e with SMTP id
 2adb3069b0e04-5b448632adbmr665709e87.35.1786466955942; Tue, 11 Aug 2026
 09:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darren Carreras <carrerasdarren@gmail.com>
Date: Tue, 11 Aug 2026 12:49:03 -0400
X-Gm-Features: AUfX_mzCKc1zRSji_u9GVMpSrOhDkao-wBGUQUti5D0XeAXmADuTuUuIASj8k8w
Message-ID: <CAOZ_KysLYww+5TT8LQO-xNnubktwfyKYtxgAsBt44S-XmZHMVg@mail.gmail.com>
Subject: [PATCH bpf-next v5] libbpf: avoid overflow in BTF.ext bounds check
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, jolsa@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, daniel@iogearbox.net, ast@kernel.org, 
	ihor.solodrai@linux.dev, eddyz87@gmail.com, andrii@kernel.org
Content-Type: multipart/mixed; boundary="0000000000004ffedc0658c84076"

--0000000000004ffedc0658c84076
Content-Type: text/plain; charset="UTF-8"

An invalid BTF.ext subsection length can wrap the pointer addition used by
btf_ext_parse_sec_info() on 32-bit builds. The wrapped pointer passes the
bounds check and parsing then reads beyond the copied BTF.ext data.

Validate the offset and length with subtraction before forming the section
pointer.

Fixes: ae4ab4b4117d ("btf: expose API to work with raw btf_ext data")
Closes: https://issues.oss-fuzz.com/issues/477315119
Signed-off-by: Darren Carreras <carrerasdarren@gmail.com>
---
Changes in v5:
- Rebase onto bpf-next commit d114bb989367.
- Attach one diff-only patch; the v4 MIME body contained a duplicated diff and
  could not be applied by CI.

Changes in v4:
- Drop the selftest because the malformed length is already rejected by the
  old check on 64-bit CI; the behavioral divergence is specific to 32-bit.
- Correct the Fixes tag to the commit that introduced the pointer-based check.

Changes in v3:
- Remove the nested mbox envelope and mail headers from the Gmail attachment
  so Patchwork's generated mbox applies with git am.

Changes in v2:
- Resend as plain text because Gmail mangled the v1 diff and Patchwork
  reported "Patch is empty."
- Include the authorized DCO Signed-off-by line.

--0000000000004ffedc0658c84076
Content-Type: application/octet-stream; name="libbpf-btf-ext-v5.diff"
Content-Disposition: attachment; filename="libbpf-btf-ext-v5.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_msowa4wj0>
X-Attachment-Id: f_msowa4wj0

ZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnRmLmMgYi90b29scy9saWIvYnBmL2J0Zi5jCmlu
ZGV4IDg0MTdkZTkyLi43NDRmMzNlMiAxMDA2NDQKLS0tIGEvdG9vbHMvbGliL2JwZi9idGYuYwor
KysgYi90b29scy9saWIvYnBmL2J0Zi5jCkBAIC0zMzY0LDcgKzMzNjQsNyBAQCBzdGF0aWMgaW50
IGJ0Zl9leHRfcGFyc2Vfc2VjX2luZm8oc3RydWN0IGJ0Zl9leHQgKmJ0Zl9leHQsCiB7CiAJY29u
c3Qgc3RydWN0IGJ0Zl9leHRfaW5mb19zZWMgKnNpbmZvOwogCXN0cnVjdCBidGZfZXh0X2luZm8g
KmV4dF9pbmZvOwotCV9fdTMyIGluZm9fbGVmdCwgcmVjb3JkX3NpemU7CisJX191MzIgZGF0YV9s
ZWZ0LCBpbmZvX2xlZnQsIHJlY29yZF9zaXplOwogCXNpemVfdCBzZWNfY250ID0gMDsKIAl2b2lk
ICppbmZvOwogCkBAIC0zMzc3LDE2ICszMzc3LDE3IEBAIHN0YXRpYyBpbnQgYnRmX2V4dF9wYXJz
ZV9zZWNfaW5mbyhzdHJ1Y3QgYnRmX2V4dCAqYnRmX2V4dCwKIAkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQogCi0JLyogVGhlIHN0YXJ0IG9mIHRoZSBpbmZvIHNlYyAoaW5jbHVkaW5nIHRoZSBfX3UzMiBy
ZWNvcmRfc2l6ZSkuICovCi0JaW5mbyA9IGJ0Zl9leHQtPmRhdGEgKyBidGZfZXh0LT5oZHItPmhk
cl9sZW4gKyBleHRfc2VjLT5vZmY7Ci0JaW5mb19sZWZ0ID0gZXh0X3NlYy0+bGVuOwotCi0JaWYg
KGJ0Zl9leHQtPmRhdGEgKyBidGZfZXh0LT5kYXRhX3NpemUgPCBpbmZvICsgZXh0X3NlYy0+bGVu
KSB7CisJZGF0YV9sZWZ0ID0gYnRmX2V4dC0+ZGF0YV9zaXplIC0gYnRmX2V4dC0+aGRyLT5oZHJf
bGVuOworCWlmIChleHRfc2VjLT5vZmYgPiBkYXRhX2xlZnQgfHwgZXh0X3NlYy0+bGVuID4gZGF0
YV9sZWZ0IC0gZXh0X3NlYy0+b2ZmKSB7CiAJCXByX2RlYnVnKCIlcyBzZWN0aW9uIChvZmY6JXUg
bGVuOiV1KSBpcyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgRUxGIHNlY3Rpb24gLkJURi5leHRcbiIs
CiAJCQkgZXh0X3NlYy0+ZGVzYywgZXh0X3NlYy0+b2ZmLCBleHRfc2VjLT5sZW4pOwogCQlyZXR1
cm4gLUVJTlZBTDsKIAl9CiAKKwkvKiBUaGUgc3RhcnQgb2YgdGhlIGluZm8gc2VjIChpbmNsdWRp
bmcgdGhlIF9fdTMyIHJlY29yZF9zaXplKS4gKi8KKwlpbmZvID0gYnRmX2V4dC0+ZGF0YSArIGJ0
Zl9leHQtPmhkci0+aGRyX2xlbiArIGV4dF9zZWMtPm9mZjsKKwlpbmZvX2xlZnQgPSBleHRfc2Vj
LT5sZW47CisKIAkvKiBBdCBsZWFzdCBhIHJlY29yZCBzaXplICovCiAJaWYgKGluZm9fbGVmdCA8
IHNpemVvZihfX3UzMikpIHsKIAkJcHJfZGVidWcoIi5CVEYuZXh0ICVzIHJlY29yZCBzaXplIG5v
dCBmb3VuZFxuIiwgZXh0X3NlYy0+ZGVzYyk7Cg==
--0000000000004ffedc0658c84076--
