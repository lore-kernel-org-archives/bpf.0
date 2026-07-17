Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACB1D435F
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307736; cv=none; b=PgckosVAahTmlTX6/GxsKkmG/7e4OSehBjB/QZ+V1x27rjcEpS5nYLhRgj7XJ0cXDTl/Abdb5KNWsmCH5G998LZs4x6T+hj4yZ+TPeAoKdWY+Resye/VJ5DbYT5L1Ad/G0BiJxyip5PM/2N3I2wHq/acEG2TJjdnsK6Rivrt7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307736; c=relaxed/simple;
	bh=YDJGf1I1MKhn6O63oKXrgMUp3tx2upjwJXx94rVqyLY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=A/5NDiOtn6wkBmpYEJBfMr3mU89k2oipDebBxLKW6RBvR5G4ONYU18/Au/kOMVIAtvPWTUfEBSxiDBl5JjmUWBc4keJlb5vRqbPV4LSwldkrQ5VNZvSIRZMQzDxXwH1axqYnuk0iu0zrxKc5DfvAuFpINal713ckpAfnjhHFsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fnn67Mz5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fnn67Mz5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472326ca506so6421804f8f.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784307732; x=1784912532; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RFvn5E/HLi7anOzIPg5BZrN/v/kHFq5z0LqYxHl8WlA=;
        b=fnn67Mz5oF9QPq34GlM++WijnRdx6VQVPwJZrf5zMkFru5zuZ65gU8bsKioGvHnJFH
         xDvkw6YygZrc1dUdA65U+Y6yL9/qaAqD5VZj0zwJabnRCkGAwxhB5fRdHBeijdKvQLI4
         ybMpIMKG/kJIYKNSozyldI8iIkIl8n4vLTUCQh6WDuzWLLxUPIApLAG/qQKK3regPKnP
         qR9rA6kX8LBFaQy3gfmRiE0IbItqj0tZfTPcSUNBjuLd+PdNxIrBgBAWdkeenJqs1f+e
         HEaFO5lh/uEah1nni+xftbaeEvUsztl4aQFjmX3qYPHRcLhScPzWFmbxN8xsaEoSgNEb
         sEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784307732; x=1784912532;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFvn5E/HLi7anOzIPg5BZrN/v/kHFq5z0LqYxHl8WlA=;
        b=DjEEfUIG3+KgNX7wbAqVTR4An2ViidISyAGW2THzbPDceBTiZrPPN4ENjFxabom3Pm
         p37tA3VrHqIznfESLwVrgmVoToySSXDDjGplLhJQxJVdsk3/cU5v6Vzczo0592DkfIOP
         asoupb7+N0ehzO4pRvf76aiWtvbHwdjZzDWVGIMZsgYNi2dCrdc3EMTrsWscjHTNLwca
         M02Nq1ggUsi4pOgQCGBTDIiXlE5WME6t63ZEE4lKGc9ecM1iZXxw+QidcRW/3u3TDxyb
         9GPuEEyHMALxh2EJfg7eEJ6efCto2elcIqIqqWmSik5il2XiPKt0rn25wZ1OtrCNL9E5
         9XTQ==
X-Gm-Message-State: AOJu0YyPmiJtwTM5VHm/9yzm5HH/HrGCBCLTXkShzIVK5NmDfUGj2lpW
	ueYyZobJviLzKdOP1nBQuqOMj9/C7HvoW6tZ+LqORqPofVNSGFgb9JYFzwYBBCx9SAc=
X-Gm-Gg: AfdE7clq5brsIOKW6XTaT6dVfPf42/wFKaUJWkDx/ALQBnQrzmZBVha0FYOkmH0Abd9
	c0ximMm295XNJyINd2gVBBbTUKz+wSJBmlSs6IY9KHg9SyJfU6bZB+HrsiXP85TnD50Qls9vfWw
	luV3vGcWx1sAlxFZfGfOwqHEeWx9QbAe+hYgzTGPZF0OSxwIwiJRQ+Ylqcm4VQBY0ZkMRQd1Sqz
	1NPzhGLaA6TxlkX0+tRAErvJ4tCF45dG23nli0VE6VozqRch44WqspWUFmEwoUqLXk/tQDygUau
	ZzvAjZzeHa2IB2lwCKhYB/38Sp1TlCI15GX4FOcKl7CNjO5Ro54jhOuHNUrfhCozjC/B7gs+Ojl
	kWaik4s0FlWYFjhJxUiqkURLdoF9Fc+Puc2Ws2wvRyWtAZK3AqTByglJAeg1+IFbE
X-Received: by 2002:a05:600c:1509:b0:495:3f5e:e7a with SMTP id 5b1f17b1804b1-4954a51dee6mr28993565e9.34.1784307732370;
        Fri, 17 Jul 2026 10:02:12 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:c3e:eeab:5970:313d:2132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4050ce3sm14792547b3.15.2026.07.17.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 14:02:08 -0300
Message-Id: <DK10AULI0UTM.QXCUVGI3J3N@suse.com>
Subject: Re: [PATCH 3/4] selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Christian Brauner" <brauner@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-146-g87073a0460e3-dirty
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-3-aa24dfd6f4f9@suse.com>
 <2088b8ed-c26c-4120-a3d6-8e6dfbf89f58@linux.dev>
In-Reply-To: <2088b8ed-c26c-4120-a3d6-8e6dfbf89f58@linux.dev>

On Thu Jul 16, 2026 at 6:11 PM -03, Ihor Solodrai wrote:
> On 7/10/26 3:09 PM, Ricardo B. Marli=C3=A8re wrote:
>> progs/lsm_bdev.c keys its verity_devices hashmap with the raw kernel dev=
_t
>> read straight off bdev->bd_dev, i.e. MKDEV(major, minor) =3D (major << 2=
0) |
>> minor. prog_tests/lsm_bdev.c instead builds its lookup key with dev_key =
=3D
>> (__u32)st.st_rdev from stat(2), but the stat(2) syscall fills st_rdev vi=
a
>> the kernel's new_encode_dev(), a different bit layout: (minor & 0xff) |
>> (major << 8) | ((minor & ~0xff) << 12).
>>=20
>> For any device with a non-trivial major these two values differ, so the
>> lookup can never find what the BPF program stored, and test_lsm_bdev()
>> always fails with:
>>=20
>>   test_lsm_bdev:FAIL:map lookup unexpected error: -2 (errno 2)
>>=20
>> Reconstruct the raw kernel dev_t from the decoded major/minor instead of
>> casting st_rdev directly, restoring the layout the BPF program actually
>> reads.
>>=20
>> Fixes: 96f4c251a087 ("selftests/bpf: add block device management selftes=
ts")
>> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>> ---
>>  tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c b/tools/t=
esting/selftests/bpf/prog_tests/lsm_bdev.c
>> index a970798e1173..28bc4b117f41 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
>> @@ -17,6 +17,7 @@
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <sys/stat.h>
>> +#include <sys/sysmacros.h>
>>  #include <sys/types.h>
>>  #include <unistd.h>
>>  #include "lsm_bdev.skel.h"
>> @@ -172,7 +173,7 @@ void test_lsm_bdev(void)
>>  	if (!ASSERT_OK(stat(DM_DEV_PATH, &st), "stat dm dev"))
>>  		goto remove_dm;
>> =20
>> -	dev_key =3D (__u32)st.st_rdev;
>> +	dev_key =3D (major(st.st_rdev) << 20) | minor(st.st_rdev);
>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> nit: I wonder if there are other tests with this bug. Have you checked?

I don't think there are.

grepping for "map lookup unexpected error" in
https://openqa.opensuse.org/tests/6106285/logfile?filename=3Dtest_progs.tap=
.txt
shows only lsm_bdev.

Tumbleweed is 7.1.3

>
>> =20
>>  	/* Look up the device in the BPF map and verify. */
>>  	err =3D bpf_map__lookup_elem(skel->maps.verity_devices,
>>=20


