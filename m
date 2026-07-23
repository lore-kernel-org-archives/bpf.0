Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283D3F1643
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840850; cv=none; b=JVH6BZCzOsSj8sQXhJ67bJhvBVQuITPD1G6ONWI2FKBWkCPj/JNNqKhjdW4E9rkgytYCyXwyVnyC7cNeBjDvsdsEFr8mXJIaWl3X/CknFimadenjUO8jC2IkbbC31rwoKq7k/uZkMTQVXWCTkGKUnI+LvUocQVkK18x+pRLUCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840850; c=relaxed/simple;
	bh=64NtZ6TFY5oUbzCiMtcjIa9v/4A/B3qirTZZ9vtRiMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIZkEADolWcugu8VWm8BY43OMUtVzQ8NIgPHjDRSwPjcaJaSEWp4b0gjZDMYyn5tFHrQg8fifbQAg59ykNX06n20OHQAnO++FDcry2WY3OLaKDKP8de4G6yLA2n2NMK0+0YXXreKIiC8uTF6ViN5BnpwOQew/dtiCh6t3N2WgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR+P/WaS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR+P/WaS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38101f85591so848413a91.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784840844; x=1785445644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7enSYTZGH6swEIjP/H8aH7xDtcUc9P3NDtiJbEh3p4Q=;
        b=LR+P/WaS41z/Le/vpDNlskCc14zHZCi94P3CdEbUVwktONO84CMtr7+hRW5EwfhfiQ
         ZwfyZtTmL/9E97IZreY9ImSUh9y0nVfOvSiy/HFcnr6/lPvHxXJ/dWGibXsnOh+rk/SD
         b2JR+cfKXYekq/I3ZgjPXJtwAslIHTOfCwr42MCyfYOmEgetNBhBwgUWLBH0AzHNqA4y
         u94aaj8XlmF/ASSpUySNf0JziW1ieCoOp9RnqgTXOh/fix0nhQP2cU3hevOZVO8b+mZN
         cb1TZlQWAMmOQzHLJmH/og4oMIe+EC6J4ziDyzph9kncGGirCnkwosDNY59ryrh48vAJ
         uXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840844; x=1785445644;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7enSYTZGH6swEIjP/H8aH7xDtcUc9P3NDtiJbEh3p4Q=;
        b=P4Km/ZDEkLXaGUpBlF9KKYe28+sHvL3lV1Au81DmkB1aPxnL5baBxNEZgmS4z46qf2
         p5TmbHdw6jIRq1IKtEuvaSBuC/XZVIUxOV9ZWZvteBB2462nspgwWtm52q3zn1dk2oUO
         Y65akzmmg0llaqvn2+xPpScvFLybOzBmXX8LRl8R58nLXzkZod87xZbQ1p4Caqhm+9EP
         L6+XSwDkAqsg2pveI5cg1sfwOCnXCxFEbjjATXA0LpeRDFY1OuKUW/9mnnDFHi4VMM7r
         jn2R+UoDLz8uflq1FkWtRz987IPE4TLvw7A2fDqQbJ1HvTJzs7N0qen8oUgggifkKTrL
         5Jeg==
X-Forwarded-Encrypted: i=1; AHgh+Rqymttxl9ZZ0HROIrmMGPKPwN663GccOplzrBNLT8GJfn6OilyD+hd7TTljPkqDvXfy/OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztgQsVJZ61c8HJ5y0A1uzSOQE+aDBCg1PeWxAbTt2iOx07kIiq
	HjbMzQluEkIlyixZkGYMOnqKTfJvkFHDlCBjBrPBn+9NiSIKyJoTGg6iqSGpGf6i
X-Gm-Gg: AR+sD11N+E8uJtDhKaWPdKkW0wwhw0gatXU6owwAPmvalPTvqo8iY1RZjB6ZbVzO+oe
	0bgkpVbxX2dsUCyofYaUfSuZ4npmNI7EXZRTcCBEYHGC4wn6jyMHEBSzkMvRCB8cjH+sKiBtcsR
	ED+tIEahFZ4ZnxP/cZN7zbPJo9rE9pHRRHz0j89nORmROYUcXubizbk6xZO2bjXNyl5hsOnJMsd
	oQPaQgq0ThbDw+2erP+Rrna53AUypnU3OSYXsux21dKuBXq2CMgNr0HEt1acGQiCVkHfDn1liA8
	xFIZnJ9bF/RDyJ/Bij7fcylqNe+raiKwk82Omk6YVsFBMMnaCYlg7hmIesUV8CKiKk2/7wAb2Uh
	R7+qa8rWfwTDNF3EYIekrYXMj/W35Oofz4/6fu4DpPL0fb7HszEgO3lX7wMDVmS4bvBgmN8tZhP
	dzViAT8eADb4dO88M302l3rHOWkzISfX63RxGbE6bTQnUQr2keG9uAjCDLkh8=
X-Received: by 2002:a17:90a:d010:b0:385:39ac:fe4b with SMTP id 98e67ed59e1d1-38ec856e5f1mr4495281a91.17.1784840844484;
        Thu, 23 Jul 2026 14:07:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c221:d012:6e37:77f9? ([2620:10d:c090:500::2:8dac])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d1302659fsm19489975c88.8.2026.07.23.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:07:23 -0700 (PDT)
Message-ID: <04c2eab092885ed738fc87f2db344bca1319a90b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Preserve pointer state for
 commuted arithmetic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	shung-hsi.yu@suse.com
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan	
 <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 14:07:20 -0700
In-Reply-To: <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
	 <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: multipart/mixed; boundary="=-mfGlp0WKzIad8/worsbW"
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-mfGlp0WKzIad8/worsbW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-22 at 05:27 +0000, Yiyang Chen wrote:
> When scalar +=3D pointer is handled in adjust_ptr_min_max_vals(), the
> destination register inherits the pointer state from the source pointer.
> Copying only selected fields is fragile because pointer provenance is
> tracked by several bpf_reg_state fields.
>=20
> Use verifier-env scratch storage to preserve the scalar operand while
> replacing the destination with the full pointer state. This preserves the
> frame number for PTR_TO_STACK registers and keeps parent identity fields
> consistent.
>=20
> Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>
>  kernel/bpf/verifier.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce0..085cbd5222737 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13726,11 +13726,14 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,

Yiyang,

I noticed there there is a temporary 'off' reg allocated on stack by
the caller of this function. So, let's reuse it, and also adjust the
sanitize_err signature to minimize changes.

Could you please re-spin using the attached patches?

Shung-Hsi, wdyt?

...

--=-mfGlp0WKzIad8/worsbW
Content-Disposition: attachment;
	filename="0002-bpf-Preserve-pointer-state-for-commuted-arithmetic.patch"
Content-Type: text/x-patch;
	name="0002-bpf-Preserve-pointer-state-for-commuted-arithmetic.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBlMjQwNGJlZWE5ODhhMzVkOGVjYjE2ZWQyYWMwYzM2ZDg3MjllMWI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZaXlhbmcgQ2hlbiA8Y2hlbnl5MjNAbWFpbHMudHNpbmdodWEu
ZWR1LmNuPgpEYXRlOiBXZWQsIDIyIEp1bCAyMDI2IDA1OjI3OjMxICswMDAwClN1YmplY3Q6IFtQ
QVRDSCAyLzRdIGJwZjogUHJlc2VydmUgcG9pbnRlciBzdGF0ZSBmb3IgY29tbXV0ZWQgYXJpdGht
ZXRpYwoKV2hlbiBzY2FsYXIgKz0gcG9pbnRlciBpcyBoYW5kbGVkIGluIGFkanVzdF9wdHJfbWlu
X21heF92YWxzKCksIHRoZQpkZXN0aW5hdGlvbiByZWdpc3RlciBpbmhlcml0cyB0aGUgcG9pbnRl
ciBzdGF0ZSBmcm9tIHRoZSBzb3VyY2UgcG9pbnRlci4KQ29weWluZyBvbmx5IHNlbGVjdGVkIGZp
ZWxkcyBpcyBmcmFnaWxlIGJlY2F1c2UgcG9pbnRlciBwcm92ZW5hbmNlIGlzCnRyYWNrZWQgYnkg
c2V2ZXJhbCBicGZfcmVnX3N0YXRlIGZpZWxkcy4KClVzZSB2ZXJpZmllci1lbnYgc2NyYXRjaCBz
dG9yYWdlIHRvIHByZXNlcnZlIHRoZSBzY2FsYXIgb3BlcmFuZCB3aGlsZQpyZXBsYWNpbmcgdGhl
IGRlc3RpbmF0aW9uIHdpdGggdGhlIGZ1bGwgcG9pbnRlciBzdGF0ZS4gVGhpcyBwcmVzZXJ2ZXMg
dGhlCmZyYW1lIG51bWJlciBmb3IgUFRSX1RPX1NUQUNLIHJlZ2lzdGVycyBhbmQga2VlcHMgcGFy
ZW50IGlkZW50aXR5IGZpZWxkcwpjb25zaXN0ZW50LgoKRml4ZXM6IGYxMTc0Zjc3YjUwYyAoImJw
Zi92ZXJpZmllcjogcmV3b3JrIHZhbHVlIHRyYWNraW5nIikKU2lnbmVkLW9mZi1ieTogWWl5YW5n
IENoZW4gPGNoZW55eTIzQG1haWxzLnRzaW5naHVhLmVkdS5jbj4KVGVzdGVkLWJ5OiBEYW5pZWwg
V2FkZSA8ZGFuandhZGU5NUBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEVkdWFyZCBaaW5nZXJt
YW4gPGVkZHl6ODdAZ21haWwuY29tPgotLS0KIGtlcm5lbC9icGYvdmVyaWZpZXIuYyB8IDE1ICsr
KysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMgYi9rZXJuZWwvYnBmL3Zl
cmlmaWVyLmMKaW5kZXggNzEyYTc3NjkzZWY1Li40NGE0MGM3NjZmODIgMTAwNjQ0Ci0tLSBhL2tl
cm5lbC9icGYvdmVyaWZpZXIuYworKysgYi9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMKQEAgLTEzNzk0
LDExICsxMzc5NCwxMiBAQCBzdGF0aWMgaW50IGFkanVzdF9wdHJfbWluX21heF92YWxzKHN0cnVj
dCBicGZfdmVyaWZpZXJfZW52ICplbnYsCiAJCXJldHVybiAtRUFDQ0VTOwogCX0KIAotCS8qIElu
IGNhc2Ugb2YgJ3NjYWxhciArPSBwb2ludGVyJywgZHN0X3JlZyBpbmhlcml0cyBwb2ludGVyIHR5
cGUgYW5kIGlkLgotCSAqIFRoZSBpZCBtYXkgYmUgb3ZlcndyaXR0ZW4gbGF0ZXIgaWYgd2UgY3Jl
YXRlIGEgbmV3IHZhcmlhYmxlIG9mZnNldC4KKwkvKiBGb3IgJ3NjYWxhciArPSBwb2ludGVyJywg
ZHN0X3JlZyBpbmhlcml0cyB0aGUgY29tcGxldGUgcG9pbnRlcgorCSAqIHJlZ2lzdGVyIHN0YXRl
LiBJbmRpdmlkdWFsIGZpZWxkcyBtYXkgYmUgYWRqdXN0ZWQgbGF0ZXIgYnkgcG9pbnRlcgorCSAq
IGFyaXRobWV0aWMuIENhbGxlcnMgZ3VhcmFudGVlIHRoYXQgYmVsb3cgZG9lcyBub3Qgb3Zlcndy
aXRlIG9mZl9yZWcuCiAJICovCi0JZHN0X3JlZy0+dHlwZSA9IHB0cl9yZWctPnR5cGU7Ci0JZHN0
X3JlZy0+aWQgPSBwdHJfcmVnLT5pZDsKKwlpZiAoZHN0X3JlZyAhPSBwdHJfcmVnKQorCQkqZHN0
X3JlZyA9ICpwdHJfcmVnOwogCiAJaWYgKCFjaGVja19yZWdfc2FuZV9vZmZzZXRfc2NhbGFyKGVu
diwgb2ZmX3JlZywgcHRyX3JlZy0+dHlwZSkgfHwKIAkgICAgIWNoZWNrX3JlZ19zYW5lX29mZnNl
dF9wdHIoZW52LCBwdHJfcmVnLCBwdHJfcmVnLT50eXBlKSkKQEAgLTEzODQxLDcgKzEzODQyLDcg
QEAgc3RhdGljIGludCBhZGp1c3RfcHRyX21pbl9tYXhfdmFscyhzdHJ1Y3QgYnBmX3ZlcmlmaWVy
X2VudiAqZW52LAogCQl9CiAJCWJyZWFrOwogCWNhc2UgQlBGX1NVQjoKLQkJaWYgKGRzdF9yZWcg
PT0gb2ZmX3JlZykgeworCQlpZiAoZHN0X3JlZyAhPSBwdHJfcmVnKSB7CiAJCQkvKiBzY2FsYXIg
LT0gcG9pbnRlci4gIENyZWF0ZXMgYW4gdW5rbm93biBzY2FsYXIgKi8KIAkJCXZlcmJvc2UoZW52
LCAiUiVkIHRyaWVkIHRvIHN1YnRyYWN0IHBvaW50ZXIgZnJvbSBzY2FsYXJcbiIsCiAJCQkJZHN0
KTsKQEAgLTE0ODU5LDggKzE0ODYwLDggQEAgc3RhdGljIGludCBhZGp1c3RfcmVnX21pbl9tYXhf
dmFscyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LAogCQkJCWVyciA9IG1hcmtfY2hhaW5f
cHJlY2lzaW9uKGVudiwgaW5zbi0+ZHN0X3JlZyk7CiAJCQkJaWYgKGVycikKIAkJCQkJcmV0dXJu
IGVycjsKLQkJCQlyZXR1cm4gYWRqdXN0X3B0cl9taW5fbWF4X3ZhbHMoZW52LCBpbnNuLAotCQkJ
CQkJCSAgICAgICBzcmNfcmVnLCBkc3RfcmVnKTsKKwkJCQlvZmZfcmVnID0gKmRzdF9yZWc7CisJ
CQkJcmV0dXJuIGFkanVzdF9wdHJfbWluX21heF92YWxzKGVudiwgaW5zbiwgc3JjX3JlZywgJm9m
Zl9yZWcpOwogCQkJfQogCQl9IGVsc2UgaWYgKHB0cl9yZWcpIHsKIAkJCS8qIHBvaW50ZXIgKz0g
c2NhbGFyICovCi0tIAoyLjUzLjAtTWV0YQoK


--=-mfGlp0WKzIad8/worsbW
Content-Disposition: attachment; filename="0001-bpf-simplify-sanitize_err-signature.patch"
Content-Type: text/x-patch; name="0001-bpf-simplify-sanitize_err-signature.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBkZjkxNDU5NTI5MjNlZjM1ZTc4NTI3NzAxMjAwZDUzYjc2ZWM4N2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT4K
RGF0ZTogVGh1LCAyMyBKdWwgMjAyNiAxMTowNDo1NSAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggMS80
XSBicGY6IHNpbXBsaWZ5IHNhbml0aXplX2VycigpIHNpZ25hdHVyZQoKVGhlIHNhbml0aXplX2Vy
cigpIGZ1bmN0aW9uIGlzIGNhbGxlZCB3aGVuOgotIHB0ciArPSBzY2FsYXIKLSBzY2FsYXIgKz0g
cHRyCi0gc2NhbGFyICs9IHNjYWxhcgpBTFUgb3BlcmF0aW9ucyBhcmUgcHJvY2Vzc2VkLgoKVGhp
cyBjb21taXQgZHJvcHMgb2Zmc2V0IGFuZCBwb2ludGVyIHJlZ2lzdGVycyBwYXJhbWV0ZXJzIGZy
b20gaXRzCnNpZ25hdHVyZSB0byBzaW1wbGlmeSB0aGUgZm9sbG93LXVwIGNoYW5nZXMgZm9yICdz
Y2FsYXIgKz0gcHRyJyBjYXNlLgpyZWdzW3NyY10udHlwZSBpcyBzYWZlIHRvIGFjY2VzcywgYXMg
aXQgaXMgbm90IG11dGF0ZWQgYnkgdGhlIGNhbGxlcnMuCgpTaWduZWQtb2ZmLWJ5OiBFZHVhcmQg
WmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT4KLS0tCiBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMg
fCAxNiArKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5l
bC9icGYvdmVyaWZpZXIuYwppbmRleCA1MmJlMGExMThjY2UuLjcxMmE3NzY5M2VmNSAxMDA2NDQK
LS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwpA
QCAtMTM2MDgsMjMgKzEzNjA4LDIxIEBAIHN0YXRpYyB2b2lkIHNhbml0aXplX21hcmtfaW5zbl9z
ZWVuKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYpCiAJCWVudi0+aW5zbl9hdXhfZGF0YVtl
bnYtPmluc25faWR4XS5zZWVuID0gZW52LT5wYXNzX2NudDsKIH0KIAotc3RhdGljIGludCBzYW5p
dGl6ZV9lcnIoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwKLQkJCWNvbnN0IHN0cnVjdCBi
cGZfaW5zbiAqaW5zbiwgaW50IHJlYXNvbiwKLQkJCWNvbnN0IHN0cnVjdCBicGZfcmVnX3N0YXRl
ICpvZmZfcmVnLAotCQkJY29uc3Qgc3RydWN0IGJwZl9yZWdfc3RhdGUgKmRzdF9yZWcpCitzdGF0
aWMgaW50IHNhbml0aXplX2VycihzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBjb25zdCBz
dHJ1Y3QgYnBmX2luc24gKmluc24sIGludCByZWFzb24pCiB7CiAJc3RhdGljIGNvbnN0IGNoYXIg
KmVyciA9ICJwb2ludGVyIGFyaXRobWV0aWMgd2l0aCBpdCBwcm9oaWJpdGVkIGZvciAhcm9vdCI7
CiAJY29uc3QgY2hhciAqb3AgPSBCUEZfT1AoaW5zbi0+Y29kZSkgPT0gQlBGX0FERCA/ICJhZGQi
IDogInN1YiI7CiAJdTMyIGRzdCA9IGluc24tPmRzdF9yZWcsIHNyYyA9IGluc24tPnNyY19yZWc7
CisJc3RydWN0IGJwZl9yZWdfc3RhdGUgKnJlZ3MgPSBjdXJfcmVncyhlbnYpOwogCiAJc3dpdGNo
IChyZWFzb24pIHsKIAljYXNlIFJFQVNPTl9CT1VORFM6CiAJCXZlcmJvc2UoZW52LCAiUiVkIGhh
cyB1bmtub3duIHNjYWxhciB3aXRoIG1peGVkIHNpZ25lZCBib3VuZHMsICVzXG4iLAotCQkJb2Zm
X3JlZyA9PSBkc3RfcmVnID8gZHN0IDogc3JjLCBlcnIpOworCQkJcmVnc1tzcmNdLnR5cGUgPT0g
U0NBTEFSX1ZBTFVFID8gc3JjIDogZHN0LCBlcnIpOwogCQlicmVhazsKIAljYXNlIFJFQVNPTl9U
WVBFOgogCQl2ZXJib3NlKGVudiwgIlIlZCBoYXMgcG9pbnRlciB3aXRoIHVuc3VwcG9ydGVkIGFs
dSBvcGVyYXRpb24sICVzXG4iLAotCQkJb2ZmX3JlZyA9PSBkc3RfcmVnID8gc3JjIDogZHN0LCBl
cnIpOworCQkJcmVnc1tzcmNdLnR5cGUgPT0gU0NBTEFSX1ZBTFVFID8gZHN0IDogc3JjLCBlcnIp
OwogCQlicmVhazsKIAljYXNlIFJFQVNPTl9QQVRIUzoKIAkJdmVyYm9zZShlbnYsICJSJWQgdHJp
ZWQgdG8gJXMgZnJvbSBkaWZmZXJlbnQgbWFwcywgcGF0aHMgb3Igc2NhbGFycywgJXNcbiIsCkBA
IC0xMzgxMyw3ICsxMzgxMSw3IEBAIHN0YXRpYyBpbnQgYWRqdXN0X3B0cl9taW5fbWF4X3ZhbHMo
c3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwKIAkJcmV0ID0gc2FuaXRpemVfcHRyX2FsdShl
bnYsIGluc24sIHB0cl9yZWcsIG9mZl9yZWcsIGRzdF9yZWcsCiAJCQkJICAgICAgICZpbmZvLCBm
YWxzZSk7CiAJCWlmIChyZXQgPCAwKQotCQkJcmV0dXJuIHNhbml0aXplX2VycihlbnYsIGluc24s
IHJldCwgb2ZmX3JlZywgZHN0X3JlZyk7CisJCQlyZXR1cm4gc2FuaXRpemVfZXJyKGVudiwgaW5z
biwgcmV0KTsKIAl9CiAKIAlzd2l0Y2ggKG9wY29kZSkgewpAQCAtMTM5MDYsNyArMTM5MDQsNyBA
QCBzdGF0aWMgaW50IGFkanVzdF9wdHJfbWluX21heF92YWxzKHN0cnVjdCBicGZfdmVyaWZpZXJf
ZW52ICplbnYsCiAJCQlyZXR1cm4gLUVGQVVMVDsKIAkJfQogCQlpZiAocmV0IDwgMCkKLQkJCXJl
dHVybiBzYW5pdGl6ZV9lcnIoZW52LCBpbnNuLCByZXQsIG9mZl9yZWcsIGRzdF9yZWcpOworCQkJ
cmV0dXJuIHNhbml0aXplX2VycihlbnYsIGluc24sIHJldCk7CiAJfQogCiAJcmV0dXJuIDA7CkBA
IC0xNDY1OCw3ICsxNDY1Niw3IEBAIHN0YXRpYyBpbnQgYWRqdXN0X3NjYWxhcl9taW5fbWF4X3Zh
bHMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwKIAlpZiAoc2FuaXRpemVfbmVlZGVkKG9w
Y29kZSkpIHsKIAkJcmV0ID0gc2FuaXRpemVfdmFsX2FsdShlbnYsIGluc24pOwogCQlpZiAocmV0
IDwgMCkKLQkJCXJldHVybiBzYW5pdGl6ZV9lcnIoZW52LCBpbnNuLCByZXQsIE5VTEwsIE5VTEwp
OworCQkJcmV0dXJuIHNhbml0aXplX2VycihlbnYsIGluc24sIHJldCk7CiAJfQogCiAJLyogQ2Fs
Y3VsYXRlIHNpZ24vdW5zaWduZWQgYm91bmRzIGFuZCB0bnVtIGZvciBhbHUzMiBhbmQgYWx1NjQg
Yml0IG9wcy4KLS0gCjIuNTMuMC1NZXRhCgo=


--=-mfGlp0WKzIad8/worsbW--
