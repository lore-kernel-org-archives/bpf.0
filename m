Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53F35F8B7
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539539; cv=none; b=l0jRK6HsFPsh3+Nls8Y/SejgdROA997xduG62qEMGJOz0D36I4RR3JcVN3mH0V7lApelV8PPq90UMM+MVNmuNFcK6xv3x5V3qdEgXsoOFYgpdzrC2mK0nxVH2rPq6jZ7jA/1MODjgHv837GMqaN043ad+Y9FWY55P/PfvxFboiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539539; c=relaxed/simple;
	bh=FEgtaVo1fZFg2EuUcwRPQAmBOP9NsfcGWcYkeoclp5Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T+r61w1TFkwnFEIY4R018zUuCIJ7Ot4ZctTXdq22dCRftg4QNG4KOVqy1GF8dyZXf1ceL4Cib5vBR1zbDWnaWnhHOsjrf3FlOOaN0o8WdN7PNZHfbYEpC4uSO4NsS231Y1LmJUq38ig3KbVKL99We04DkL5gz7QdnoKhH93kJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=TXD4HOQm; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="TXD4HOQm"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70daf9c94so77814485a.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769539537; x=1770144337; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd28Q7mBb92UgK0u2k9ZSWCozvWb4RHDUvvHPuD1jPY=;
        b=TXD4HOQmUcct0YrBWMpTHtCj3mjShjUq8n+TU+mc4O/iIblNCqoSI+xI/wf2TAtify
         KLcpx0/AfKMZ5H02X3iobJvsNznAK50W8aVW0hMQXP5x9oh15PXUq1iqvl8dBxMk/aCP
         YcuzxHDobS9NR3/C6Mdk6sYmWCK+WOYZ2XHM+CwZpScB9+j9XBLNWoJBhTw2nywQid5P
         MDDbGxTn7Yc94zQQ403I7QIN/71T35QiaTA6DLeUeOoPqj1q1glt97Vru4Dj14wJJxni
         p1wie0gdmBMMI6wsEwAgNPVXYELml9TfdsjUp0feV8dOton3nXTH+M0Gh+wEgbdQirM5
         FjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539537; x=1770144337;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd28Q7mBb92UgK0u2k9ZSWCozvWb4RHDUvvHPuD1jPY=;
        b=Zv/27St2zcGxSxKV6DoNPD3cHj4VpZ87GRz1WxCmTwKFuoezs33uOguMidzk+15Jua
         k9TsICg4gpGPAunafRFGpBvWgb4HrOV9/YnjWDD4ndg5Ah6brXd/rHoBlS8q2dh7xOvF
         sNzGB+SRNQUAXLx/JZK1Z5aznuyCZlvYQx+nn3hnGT8ZKdvRNDDbC0/YIQWDgnpcy9vS
         9/b58BlmEpS3zoGFddcfl0fSgPaqUC4NRWpUo1VKsqVJeUyPO0HWnYy8muIW13X9h8A/
         +NDbYEv9tye2pDkb8O41WgvLXZFihPdMWDLp8DQ17qmT3n3tKsrg4A9T91BUg/1GIBbz
         EAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl3pxtQc/zb1KvGmtA0kPpu+ggayis9DDzE6y6sXPX1CAGqJWHutmKaNVaHfNo6k8oVQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEz3dhjUA7dSPg6SblxPGYlV1HO+j4BGkFidMFtK2XszlU3ay
	1UZA3kvQsbBxbrI2Ll6oAw6Ybb5xJ+1r1v+LUv2gM/9/fMjk05KtQ7vOF1B7UVe3XFI=
X-Gm-Gg: AZuq6aIYqqs7WtKEk2ELx8/JCSFfzA0CKFaLmvJvez8hGEoRjZX0TmROu/WonVR0ELM
	g0Y/+Map+podswSHN+Rpu4jDwzRUcnKSohTiBjZjhUPn19f/l3tUAiaABfV1dmq/J1dwXfF+2rN
	4IdUaEwrFWJofp8H7suPjqihT6qgj8FyVeCgHxof2xkFMX1owIy9VsqSL5+jyzomaE63aJkjRIO
	YCNXFFy7xG/MLBzrkEg34Uyol70Mbi2SJteWdd+8Vkl44PpEf8Vsx1O0lx5MjYWiw4UIaBZbj8G
	kuegZMUYb7aHWxzkohDxOakWarlBsjTDuMJeYU5lyT5rD7af9myYOnf//ffcDYA+GuHAUCwj6d4
	kTYR3irbjq/c+MnIaz/IcTN3yAtEYs+zXicnnig9d15KYcMBxABSjRWW7GhV6f8M304NwLMIY48
	BkismdLpJNp/4=
X-Received: by 2002:a05:620a:2995:b0:8b3:16c:1a79 with SMTP id af79cd13be357-8c70b8e6013mr318992185a.53.1769539536938;
        Tue, 27 Jan 2026 10:45:36 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5b663sm25382085a.49.2026.01.27.10.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 13:45:35 -0500
Message-Id: <DFZLEW55QIGU.VTQKPNOP181D@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <etsal@meta.com>, <ihor.solodrai@linux.dev>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <puranjay@kernel.org>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>
Subject: Re: [PATCH v2 07/13] selftests: bpf: Add ASAN support for libarena
 selftests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260127181610.86376-8-emil@etsalapatis.com>
 <c754c6bb656d78e6ab566d3308a9a261cab980c622adab5213127e8d729efb03@mail.kernel.org>
In-Reply-To: <c754c6bb656d78e6ab566d3308a9a261cab980c622adab5213127e8d729efb03@mail.kernel.org>

On Tue Jan 27, 2026 at 1:38 PM EST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b=
/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>> index 5b8d8b94323e..f63324a1cdde 100644
>> --- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>
> [ ... ]
>
>> @@ -211,8 +269,17 @@ static void
>>  banner(const char *progpath)
>>  {
>>  	char *name =3D basename(progpath);
>> +	bool is_asan;
>> +
>> +	/*
>> +	 * Check if our BPF programs are ASAN-capable by inspecting the prog n=
ame.
>> +	 * Command line arguments are guaranteed to be NULL-terminated, use st=
rlen.
>> +	 * Calculate the hardcoded name's length at compile time.
>> +	 */
>> +	printf("%s\n", name);
>> +	is_asan =3D strstr(name, "_asan");
>
> This isn't a bug, but the comment mentions strlen and compile-time length
> calculation, while the actual code uses strstr(). Should the comment be
> updated to match the implementation?
>

Ack, will update.

>> +
>> +	printf("=3D=3D=3D %s %s=3D=3D=3D\n", "libarena selftests", is_asan ? "=
(asan) " : "");
>>  }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/214092=
86496
>
> AI-authorship-score: low
> AI-authorship-explanation: Code follows standard kernel patterns with a c=
omment/code mismatch typical of iterative human development rather than AI =
generation.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor documentation issue where comment menti=
ons strlen and compile-time calculation but code uses strstr; does not affe=
ct functionality.

