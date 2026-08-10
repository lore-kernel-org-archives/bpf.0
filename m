Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E5441638
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390530; cv=pass; b=n2EbQEmX+zF/zph6LME3a4ykTZmYYfAx1Ht8V3ZBEzWtcH0kyQZo4lpMZRMP8m2QBMh9DslJoB6aDC1lC4WsNVwjBV9DdFD72n8X4cbygM5LoQkSDUsZqu9IwNNBOD4h4quh2JVECkAlge+9E0ZQxVwrSW+4ZUPaiSVF2EvOWlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390530; c=relaxed/simple;
	bh=SBhIDU6Lmjca1axxuJDjlzfzu7g90AA92IIyhyHGvro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kPhf+aRnstnfDU0VcnLxKHYorUlRjiE8diUCCaWtMWAYWDRdorBsWs1wxUjMTo2AQb/inJRuxHp4r2XKTGXipZIL8yy3/r7Y2vKhqmEzZ6t4ZkPh/KnwAn6/hsFIGqIcUSESIy9YZvOGtKhE+BwVmIz1ONeoQrXwBKBPjPyxW3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg4iM9j2; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg4iM9j2"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39ca0a30148so19347831fa.3
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786390527; cv=none;
        d=google.com; s=arc-20260327;
        b=n1/YgLaINLaQ/kluriNkjbTU5ZB+W+v37DfKURuGXRmU3a2M3xxAaM0Ijquxfh8JXU
         pRj3tS6lL6Wklho2lKb3iAl6hTOQY0YaCAW62LYlH/+LkK2fCrmc1ynfXP+37ViAUMOP
         AGTRDf+kvXlXLmWYeUpbuICFcGCYkuYhGe2GONsTR+DZQdw0JN7JftpAC19FJfL4B/4D
         6E2gWwP5t7TABFPnR3mhZlbxmypFdggwgq4eBoOCJs7hodF7+A8S9BSa0yCnuaZ69Qlk
         eX3pW5YBuXyWXYFDmIzf9jsgUnJxESag1CTG3EoLa6oBuqQTG41/YFRbT4fWoyq2FZeO
         K/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=J/t6fURBAKyX5FGlpme1NUFBZEdJt4gc/xTYFbQJF9g=;
        fh=KepTD2eORxmjIWP3EGUAsPZWmV+isJOHCQYVTLjfXsk=;
        b=EK6ReM7hsSoanKVRvGiFUevOmIJIzzv19RBOge3wXknLcDUn+H5e3jq/N52/daVARm
         wyUc9RBlblXtWUnKPxYX9k6JKezqV0yK2IcbA38wi7PM3SSKA7gfR2WlH6cxfdvznD6P
         CaqKLBPtwmdJ3gifcnGCQ6HkGFAZOTrcUJ8MAS17SIILXrlfRHq7Wj7JMtVSkYGP4Jwa
         M9AL3Bh94R0J1JcO+0/cjGteRGBOSWbR6zvtTzj0gWklY3AFT9M8ReiQau0usFIMQb3j
         84E9rcJ2w/XtYKAT6fvjcFuS2d7TNxRrSO+NydhRovxQv+4yJIXHDaGtthvjO5x4t/1z
         BSgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390527; x=1786995327; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J/t6fURBAKyX5FGlpme1NUFBZEdJt4gc/xTYFbQJF9g=;
        b=Mg4iM9j2OuR4qKwpsjPUIqRj5ZZp50I5NbO0R7nBJJKQdg6sG5jfkibWk5kWhIv9dT
         3QSfP06f0rakCjHI3LfYh8DtE0JBxti9eSiJfBkGJEAxRepxyF3k3maT0/IHMgLT9IMU
         M6dQXg0lF10P8DIk6TUtktUGw2bYgKrJ1rlrU0UesUXQk51W5P3N9FcuZYIOttO6dCwx
         y2Oh7sAXSr1tpNjoD2T+E9/21u5UBgrgsHHgXrasV+m0O3NcsWnLQDty8ILRMb9DLMD5
         DXHXm6eSVwGKkkqHSTN4mZ+3qGhJ3OF+txWWzZbrh2Dt4angWRp9sZgXfzx0nsJvJL6f
         at9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390527; x=1786995327;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J/t6fURBAKyX5FGlpme1NUFBZEdJt4gc/xTYFbQJF9g=;
        b=ZY6gTH0WqEjG/w4UmTsX58Uju6AuZ+WFEFsxx29KW+E1Do8eTCPl41s0uDypwY7FqK
         BFeigthOmT5kuv8bV8wiD+BTeNyvqdJ/aiilFF5lIGPmcdVOn9TOw0oS5yNEfPYCOQpW
         VCnJPpRL0wjJygMr/JatP/lN/TaoFHdxrn+t99bD975t4KhlmPhXo1d+jHM/D3JcevPk
         aQ1GEKDRIFV90t5/Yh2UNb1sgLaWkGL0F4ft69elhGP3d4IsvEtLzXRuQRZlvYGnOVFV
         dZZTapV0xl5SZrwfQntbzxbyrFMxXROPaGjFm2T7aVy6UZFzcGGBBO3kO/jb+1hPO+lo
         QCJw==
X-Gm-Message-State: AOJu0Yzhaob/SPlG6gj2ism1bBhKI4eEVWkWoigdT1H8oifbz6g+mOCU
	2Kc+kW+TtjmcGPvvziozBvBmWrjSJt4SKvOuYYKnQ6FadfMFI1+I4gU9G5FMzXuBXYM+Vxmxe8Y
	mccIBoH3ywYgMTi+8GopcfxOwLOhdfYqqzZIOKU4=
X-Gm-Gg: AR+sD11L7kA7npn5AyhLYNBJknBgDHbNJHB2nie9XqrdBhKA5kvi+a/2y86PJGrlMLG
	VWbeH8ErJllwiKs/7Us88X6oAZVUkW/nVUY5UZutyeX/oyXrLViuF0qlHU1mIkMIDpjjY3gX1QI
	O7JZg4XMH5Y8BzT0WgPq7NXgUYQ7TX9dK/CQLRcQThIN3wsOcxCydLUSGzBygnjQYBhdnkzJAQ7
	BeeQ0jhxfuXDa9IIJl9aLoxVz6UagS7V+0n5GA2G58HlY4xjhydSla5bBJQuOeTptkT9ZKhiMlz
	H9lVfRrX90rW+fEgvjvNfjNUhq27oSsJC+t+Mk1LQ9ZvLJ6zq+0LdVtEwcaBmePFH8jvE7y+O/l
	Gl93s+sz71EHiH//NtbdbpJDFaLePSsNcMSoOzGg7i4vKupSLbhzZxzzx7zI=
X-Received: by 2002:a2e:a801:0:b0:39c:72ef:6d65 with SMTP id
 38308e7fff4ca-3a00eaf09e6mr5552621fa.28.1786390526640; Mon, 10 Aug 2026
 12:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darren Carreras <carrerasdarren@gmail.com>
Date: Mon, 10 Aug 2026 15:35:14 -0400
X-Gm-Features: AUfX_my5wy7DEDbrlTowpPrOuLMT_W9pb808pJuwA35fhwhVPxM4O2kr7Dbc5Iw
Message-ID: <CAOZ_KyvH-Q+-A1wsTETaq9QoPuxAuVfN2o0eNua0rHSEy=RNAQ@mail.gmail.com>
Subject: [PATCH bpf-next v2] libbpf: avoid overflow in BTF.ext bounds check
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, jolsa@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, daniel@iogearbox.net, ast@kernel.org, 
	ihor.solodrai@linux.dev, eddyz87@gmail.com, andrii@kernel.org
Content-Type: multipart/mixed; boundary="000000000000c55c1a0658b67405"

--000000000000c55c1a0658b67405
Content-Type: text/plain; charset="UTF-8"

Resending v2 because Gmail mangled the inline v1 and Patchwork
reported "Patch is empty." The complete git-format-patch output is
attached as a text/plain part; its decoded bytes apply cleanly to
current bpf-next d114bb989367.

The attachment includes the v2 changelog and authorized Signed-off-by line.

--000000000000c55c1a0658b67405
Content-Type: text/plain; charset="US-ASCII"; 
	name="v2-0001-libbpf-avoid-overflow-in-BTF.ext-bounds-check.txt"
Content-Disposition: attachment; 
	filename="v2-0001-libbpf-avoid-overflow-in-BTF.ext-bounds-check.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_msnms5y30>
X-Attachment-Id: f_msnms5y30

RnJvbSBiMDBjYzEzNmVlY2MxMzBlMzA4MWZhYWNlNTM0MGIyNWNhNmZjOTRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXJyZW4gQ2FycmVyYXMgPGNhcnJlcmFzZGFycmVuQGdtYWls
LmNvbT4KRGF0ZTogTW9uLCAxMCBBdWcgMjAyNiAxNToxMDo1NyAtMDQwMApTdWJqZWN0OiBbUEFU
Q0ggYnBmLW5leHQgdjJdIGxpYmJwZjogYXZvaWQgb3ZlcmZsb3cgaW4gQlRGLmV4dCBib3VuZHMg
Y2hlY2sKCkFuIGludmFsaWQgQlRGLmV4dCBzdWJzZWN0aW9uIGxlbmd0aCBjYW4gd3JhcCB0aGUg
cG9pbnRlciBhZGRpdGlvbiB1c2VkIGJ5CmJ0Zl9leHRfcGFyc2Vfc2VjX2luZm8oKSBvbiAzMi1i
aXQgYnVpbGRzLiBUaGUgd3JhcHBlZCBwb2ludGVyIHBhc3NlcyB0aGUKYm91bmRzIGNoZWNrIGFu
ZCBwYXJzaW5nIHRoZW4gcmVhZHMgYmV5b25kIHRoZSBjb3BpZWQgQlRGLmV4dCBkYXRhLgoKVmFs
aWRhdGUgdGhlIG9mZnNldCBhbmQgbGVuZ3RoIHdpdGggc3VidHJhY3Rpb24gYmVmb3JlIGZvcm1p
bmcgdGhlIHNlY3Rpb24KcG9pbnRlci4gQWRkIGEgc2VsZnRlc3QgdXNpbmcgYW4gb3ZlcmZsb3dp
bmcgZnVuY19pbmZvX2xlbi4KCkZpeGVzOiBjZjU3OTE2NGU5ZWEgKCJsaWJicGY6IFN1cHBvcnQg
QlRGLmV4dCBsb2FkaW5nIGFuZCBvdXRwdXQgaW4gZWl0aGVyIGVuZGlhbm5lc3MiKQoKQ2xvc2Vz
OiBodHRwczovL2lzc3Vlcy5vc3MtZnV6ei5jb20vaXNzdWVzLzQ3NzMxNTExOQpTaWduZWQtb2Zm
LWJ5OiBEYXJyZW4gQ2FycmVyYXMgPGNhcnJlcmFzZGFycmVuQGdtYWlsLmNvbT4KLS0tCkNoYW5n
ZXMgaW4gdjI6Ci0gUmVzZW5kIGFzIHBsYWluIHRleHQgYmVjYXVzZSBHbWFpbCBtYW5nbGVkIHRo
ZSB2MSBkaWZmIGFuZCBQYXRjaHdvcmsKICByZXBvcnRlZCAiUGF0Y2ggaXMgZW1wdHkuIgotIElu
Y2x1ZGUgdGhlIGF1dGhvcml6ZWQgRENPIFNpZ25lZC1vZmYtYnkgbGluZS4KCiB0b29scy9saWIv
YnBmL2J0Zi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMyArKysrKy0tLS0tCiAuLi4v
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3RfYnRmX2V4dC5jICAgfCAyNCArKysrKysrKysr
KysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9idGYuYyBiL3Rvb2xzL2xpYi9icGYvYnRm
LmMKaW5kZXggODQxN2RlOS4uNzQ0ZjMzZSAxMDA2NDQKLS0tIGEvdG9vbHMvbGliL2JwZi9idGYu
YworKysgYi90b29scy9saWIvYnBmL2J0Zi5jCkBAIC0zMzY0LDcgKzMzNjQsNyBAQCBzdGF0aWMg
aW50IGJ0Zl9leHRfcGFyc2Vfc2VjX2luZm8oc3RydWN0IGJ0Zl9leHQgKmJ0Zl9leHQsCiB7CiAJ
Y29uc3Qgc3RydWN0IGJ0Zl9leHRfaW5mb19zZWMgKnNpbmZvOwogCXN0cnVjdCBidGZfZXh0X2lu
Zm8gKmV4dF9pbmZvOwotCV9fdTMyIGluZm9fbGVmdCwgcmVjb3JkX3NpemU7CisJX191MzIgZGF0
YV9sZWZ0LCBpbmZvX2xlZnQsIHJlY29yZF9zaXplOwogCXNpemVfdCBzZWNfY250ID0gMDsKIAl2
b2lkICppbmZvOwogCkBAIC0zMzc3LDE2ICszMzc3LDE3IEBAIHN0YXRpYyBpbnQgYnRmX2V4dF9w
YXJzZV9zZWNfaW5mbyhzdHJ1Y3QgYnRmX2V4dCAqYnRmX2V4dCwKIAkJcmV0dXJuIC1FSU5WQUw7
CiAJfQogCi0JLyogVGhlIHN0YXJ0IG9mIHRoZSBpbmZvIHNlYyAoaW5jbHVkaW5nIHRoZSBfX3Uz
MiByZWNvcmRfc2l6ZSkuICovCi0JaW5mbyA9IGJ0Zl9leHQtPmRhdGEgKyBidGZfZXh0LT5oZHIt
Pmhkcl9sZW4gKyBleHRfc2VjLT5vZmY7Ci0JaW5mb19sZWZ0ID0gZXh0X3NlYy0+bGVuOwotCi0J
aWYgKGJ0Zl9leHQtPmRhdGEgKyBidGZfZXh0LT5kYXRhX3NpemUgPCBpbmZvICsgZXh0X3NlYy0+
bGVuKSB7CisJZGF0YV9sZWZ0ID0gYnRmX2V4dC0+ZGF0YV9zaXplIC0gYnRmX2V4dC0+aGRyLT5o
ZHJfbGVuOworCWlmIChleHRfc2VjLT5vZmYgPiBkYXRhX2xlZnQgfHwgZXh0X3NlYy0+bGVuID4g
ZGF0YV9sZWZ0IC0gZXh0X3NlYy0+b2ZmKSB7CiAJCXByX2RlYnVnKCIlcyBzZWN0aW9uIChvZmY6
JXUgbGVuOiV1KSBpcyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgRUxGIHNlY3Rpb24gLkJURi5leHRc
biIsCiAJCQkgZXh0X3NlYy0+ZGVzYywgZXh0X3NlYy0+b2ZmLCBleHRfc2VjLT5sZW4pOwogCQly
ZXR1cm4gLUVJTlZBTDsKIAl9CiAKKwkvKiBUaGUgc3RhcnQgb2YgdGhlIGluZm8gc2VjIChpbmNs
dWRpbmcgdGhlIF9fdTMyIHJlY29yZF9zaXplKS4gKi8KKwlpbmZvID0gYnRmX2V4dC0+ZGF0YSAr
IGJ0Zl9leHQtPmhkci0+aGRyX2xlbiArIGV4dF9zZWMtPm9mZjsKKwlpbmZvX2xlZnQgPSBleHRf
c2VjLT5sZW47CisKIAkvKiBBdCBsZWFzdCBhIHJlY29yZCBzaXplICovCiAJaWYgKGluZm9fbGVm
dCA8IHNpemVvZihfX3UzMikpIHsKIAkJcHJfZGVidWcoIi5CVEYuZXh0ICVzIHJlY29yZCBzaXpl
IG5vdCBmb3VuZFxuIiwgZXh0X3NlYy0+ZGVzYyk7CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90ZXN0X2J0Zl9leHQuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3RfYnRmX2V4dC5jCmluZGV4IDdkMWI0NzguLjc3
ZGI4N2QgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3Rz
L3Rlc3RfYnRmX2V4dC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rl
c3RzL3Rlc3RfYnRmX2V4dC5jCkBAIC0xLDkgKzEsMzEgQEAKIC8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wCiAvKiBDb3B5cmlnaHQgKGMpIDIwMjUgTWV0YSBQbGF0Zm9ybXMgSW5j
LiAqLwogI2luY2x1ZGUgPHRlc3RfcHJvZ3MuaD4KKyNpbmNsdWRlICJicGYvbGliYnBmX2ludGVy
bmFsLmgiCiAjaW5jbHVkZSAidGVzdF9idGZfZXh0LnNrZWwuaCIKICNpbmNsdWRlICJidGZfaGVs
cGVycy5oIgogCitzdGF0aWMgdm9pZCBzdWJ0ZXN0X2ludmFsaWRfaW5mb19sZW4odm9pZCkKK3sK
KwlzdHJ1Y3QgeworCQlzdHJ1Y3QgYnRmX2V4dF9oZWFkZXIgaGRyOworCQlfX3UzMiByZWNvcmRf
c2l6ZTsKKwl9IHJhdyA9IHsKKwkJLmhkciA9IHsKKwkJCS5tYWdpYyA9IEJURl9NQUdJQywKKwkJ
CS52ZXJzaW9uID0gQlRGX1ZFUlNJT04sCisJCQkuaGRyX2xlbiA9IHNpemVvZihyYXcuaGRyKSwK
KwkJCS5mdW5jX2luZm9fbGVuID0gVUlOVDMyX01BWCAtIDcsCisJCX0sCisJCS5yZWNvcmRfc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgYnBmX2Z1bmNfaW5mb19taW4pLAorCX07CisJc3RydWN0IGJ0Zl9l
eHQgKmJ0Zl9leHQ7CisKKwlidGZfZXh0ID0gYnRmX2V4dF9fbmV3KCh2b2lkICopJnJhdywgc2l6
ZW9mKHJhdykpOworCWlmICghQVNTRVJUX0VSUl9QVFIoYnRmX2V4dCwgImludmFsaWRfaW5mb19s
ZW4iKSkKKwkJYnRmX2V4dF9fZnJlZShidGZfZXh0KTsKK30KKwogc3RhdGljIHZvaWQgc3VidGVz
dF9saW5lX2Z1bmNfaW5mbyh2b2lkKQogewogCXN0cnVjdCB0ZXN0X2J0Zl9leHQgKnNrZWw7CkBA
IC01OSw2ICs4MSw4IEBAIHN0YXRpYyB2b2lkIHN1YnRlc3RfbGluZV9mdW5jX2luZm8odm9pZCkK
IAogdm9pZCB0ZXN0X2J0Zl9leHQodm9pZCkKIHsKKwlpZiAodGVzdF9fc3RhcnRfc3VidGVzdCgi
aW52YWxpZF9pbmZvX2xlbiIpKQorCQlzdWJ0ZXN0X2ludmFsaWRfaW5mb19sZW4oKTsKIAlpZiAo
dGVzdF9fc3RhcnRfc3VidGVzdCgibGluZV9mdW5jX2luZm8iKSkKIAkJc3VidGVzdF9saW5lX2Z1
bmNfaW5mbygpOwogfQo=
--000000000000c55c1a0658b67405--
