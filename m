Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD193A1B5
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238761; cv=none; b=uCOMQphem+hu/o4/N2JZR/41WtBJgL1B/DqAq/2n9fMCYI2GKeeHmqo0RAzQsyuZ/t8AwbTN707Y/g58c0/tO8rm+guMA+CwOCePQtxJURxc+ouOwIcivMzXhNM8vMpUl7Kyw5AXsmFEOwNBr6X87Z7kTKrRKci1eJbsH6RKvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238761; c=relaxed/simple;
	bh=VoLZ/kjVbIJeJrmJ2HDcRN4hQgF5Jyte/hIy7nL/oZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cSxz8gwKEeYhUQ1FCyKgacFwQbueTJ/q3s57t3KC9b0mrBUm57PL3em3FbfVrlDQJVpEHK6e3aGtJK1BN3dG83kgAq/htxD+xNLOzfB+owXS+2m0PMevxncjeSTGxOcg0mFs93pdupLYmRCN+69MOGW0YPLDzuGCzS6adTM02vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=XBg4Erpz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="XBg4Erpz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a297c14bso24324991cf.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 16:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772238759; x=1772843559; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM1nV9pmAJcBQ/IyG8SpAzWnDmpPBB840s7Wl9lRoO8=;
        b=XBg4Erpziz+Ivw9ruQfGOqPJoKtjJJhrB0O/y0G22VyylPG1tepoKkQDSjoUYtxPUX
         WrytZ3Oa6EQX8faK4W4ud/PUeaF0fk0HcNIs0Uy7bT2qWxhF/QiBEIV0nEU6RYtiRA2c
         k+nBSa2GwguEaigNCVjZMnbRG6hvKHs2rykxzEDp06Y3kTd9krGLA9Og8THLXwOWiUms
         lDueo32IfjdFcF1BumN3sWSQQXNLErbvhHDDRF9G4Y3/hy8kh1jP5Lh+OKO0dQC/lVer
         x6cbicMO90qw9RkTZqMdZiyOWpRgDV6hA/RSI1Mpe+SsiH46UAtAs+3RYqpXm16cZOIZ
         4nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772238759; x=1772843559;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM1nV9pmAJcBQ/IyG8SpAzWnDmpPBB840s7Wl9lRoO8=;
        b=l7bIMz86sPKs9JzAHBMPp8HWOaUMnbNNGcJ0GtLe59qLT+6VMULlzfRd2oKx9dRmdA
         /gAe60MSG2f9snGUjIkFHjdEEb+i6KuchqljmDbKE1LnE7FKfLUP51UtJXv9wP32JMi9
         fXSM3mTELqUSv1WOwil//PPcTQAzjeQTIELX5Z6sE2oXoX2XWEDmoUkxCnPb9twv7ZdL
         KMeuj6BEqsTM4xlBRUDka3+GP8lt0b3K10GoCY6zH0x+i+fZFIHVPxcnjVQIBh0RpIdg
         1x6FKs9cE7W7H5oPJJBAaAId7rfQ1HHCUWUE/sAQXQas7oiYb3PlTwiOjeH7JUr0JbSv
         lEsw==
X-Forwarded-Encrypted: i=1; AJvYcCX/cIKbDbV/yGTNdbcEelkLQFOhmdidkyUU0OenF9ycgU1Z0eyBkA3p8jouVRkrk/36J1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiA0TPPfIoohcW/tn7hvv5jNv2uoRDEOoH1+JSijH5XThEiur+
	2XzmMsM0nsFvA4ymigaaSmJ4FOQW5nJodnNG6eItK2kb13Fh/k9S8VVuMv6bgWJHn/w=
X-Gm-Gg: ATEYQzzo8sCSlbWbgkB4p53qvg16pny8ke5Vxp3/PF7ZXp2OeFGrYbaGX5YLSsxrTU5
	c5JJLS5kt0iSUpYhLdLIJVD2rQDjFkfgYKBxDxCAaSahAOlyHMKUAQ5j8IDz2tiZM17CHuEIDbH
	uBdNfKJDI5fzffxqkwwQfnPHSXrrkeI8R/TPJVP0OnemIqBZ0s4KlNu5zqcdK7aE2KC/AE/Miov
	ed+mOymKSZFkaJc8eSKtWuQ62Oy+mlu8RkVcRegvsvZPiqyt9cNFXD5NwjF0VlCASkIqD5PDVX/
	nVzKsUVja+ae+Bo0eZDEblBvGtzLPy7WmWYMpFF3qUNzbR/FiKwPJacVYImzXHWQFFsXd84v76p
	OWThOwRz4gtPiiaJS4U9HBL/9XwEYDotSOGH+A9LAEzFYKJ6K6vlXekGgRSWtVsbPdV5tDbQppw
	/bJI7tHwbXNXvFc+NyY7dvo/4=
X-Received: by 2002:a05:622a:1449:b0:506:9b3a:2199 with SMTP id d75a77b69052e-50752a24424mr62656021cf.67.1772238758573;
        Fri, 27 Feb 2026 16:32:38 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449a66f1sm61683621cf.12.2026.02.27.16.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 16:32:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 19:32:37 -0500
Message-Id: <DGQ67HFP5MZ4.PK4W3X8DTMQ6@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 5/5] selftests: bpf: Add tests for void
 global subprogs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
X-Mailer: aerc 0.20.1
References: <20260227154616.6846-1-emil@etsalapatis.com>
 <20260227154616.6846-6-emil@etsalapatis.com>
 <3b9d736ab4b73ba79b237163d31b86bd50c34508.camel@gmail.com>
In-Reply-To: <3b9d736ab4b73ba79b237163d31b86bd50c34508.camel@gmail.com>

On Fri Feb 27, 2026 at 2:53 PM EST, Eduard Zingerman wrote:
> On Fri, 2026-02-27 at 10:46 -0500, Emil Tsalapatis wrote:
>> Add additional testing for void global functions. The tests
>> ensure that calls to void global functions properly keep
>> R0 invalid. Also make sure that exception callbacks still
>> require a return value.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/freplace_int_with_void.c =
b/tools/testing/selftests/bpf/progs/freplace_int_with_void.c
>> new file mode 100644
>> index 000000000000..8b6f5776cf0f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/freplace_int_with_void.c
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/bpf.h>
>> +#include <linux/pkt_cls.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +volatile int data;
>> +
>> +SEC("freplace/global_func2")
>> +void test_freplace_int_with_void(struct __sk_buff *skb)
>> +{
>> +	data =3D 1;
>> +}
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/freplace_void.c b/tools/t=
esting/selftests/bpf/progs/freplace_void.c
>> new file mode 100644
>> index 000000000000..cfa4af00991d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/freplace_void.c
>> @@ -0,0 +1,12 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +volatile int data;
>> +
>> +SEC("freplace/foo")
>> +void test_freplace_void(struct __sk_buff *skb)
>> +{
>> +}
>> +
>> +char _license[] SEC("license") =3D "GPL";
>
> Nit: still think that 'data' is not necessary in the above two hunks.
>
This slipped through last review, sorry. Will fix.
> [...]

