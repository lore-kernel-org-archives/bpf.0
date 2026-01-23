Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D7347FFE
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137268; cv=none; b=gYZGdfobTcPe/5oKVkUpNWdQLN3I3jrNJJqHSS+woR+mety8/OoWDR4Hjw/TjdvvI74EMhzYd9x+SpPQbXDrlpunktd6TTUoV1XiyunHyl0cCxXZd+LE4yP1cPk46ZFCXwRZiQGC6f7uEqQ36Y30i43nA0gWCRP+uHeIcmMRp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137268; c=relaxed/simple;
	bh=42ZPnYjBOMS4VlfUBCHT88TFqcupYnGssEakPXecMcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mi0lT2HiwB+q5RtvOloRHqlpD9oYAp+56YXs86EMykiHuOcJgqhsho2QtzOn9gBuB8cccwKCdC0h1tW/PBjq0cxDBSyRx4hunp2f1VXhI+B0jFeoZohh58JZwZFhSeOWewFUk32cTw+x3bHB1VPX/uNtVEn7SDE8qOREglT8wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=XIhFAHNQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="XIhFAHNQ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5029af2b4bcso9122441cf.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 19:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769137251; x=1769742051; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DibzgHm6COr/0ycruy3r18Vg6zacv3Z1kXkaYCk+9Pc=;
        b=XIhFAHNQ3eyB2FvXr7C96+M9TQmteOR+Mo2VoYeyhOWen/Y+vm+IShO7cVcvJX8iwv
         YmGMNAUo9+QuyucD3DGLOD/LQOHmszY98oGSgmlCVjNo9bEi34sYBgXrFkEAZ5T0Dej+
         ktPJ29qG/6Xy03YukKBG6JMTuYMJjgVk66hg5zIjxOUe6BNSEjU9TpJF7dXLRiEh71cg
         VwlmVEjcN2qC/EXrLm6VfzIyEt9PRAetFo7afBqiiQxwHWg1DpsccJMqbVbEs/xpIEKm
         nAkma3Ukcxdyk2cWybdXO5faY2FbVbnA65O3J/wKlDcmDivgSjmrcmPTFZ5MvOZYGvfz
         ZeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137251; x=1769742051;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DibzgHm6COr/0ycruy3r18Vg6zacv3Z1kXkaYCk+9Pc=;
        b=M/vhxAQdyg3sNX31oBA6AH9igLfP43s5jm6H3aP1PCL8kQ6Z3Yadbs0f+v/ZFsw0QQ
         yeDfvzjf7JrACFPG6P6O5OCul7xDCYyOFGbG7tIJKKEYjlX6PuRRPk7XFwym/UqnG4Jx
         D17TXd0S+ejrSRv8GrJwqEMaPPfsnknGg3WOpUNnlDZMpYcynX/MALHPDz2VFjKDOa7C
         +nur0etQk+bqshMZLUW/8xU9yHqd2wIiyYR1vgCdDWV2XDL9aiXKKq7AcSCiU9PzRaWW
         9ZPUqTafA4dyT7N7BtY6LZkbeX5bbOziUoa2SQ5x4NkaqOLepqQAmr7qilXRLvATHr1d
         ZrIg==
X-Forwarded-Encrypted: i=1; AJvYcCX4xQavNiA2oVfNVu60bPjBGBYTfRh322MY3DRDZk3brYhSy78u2eOIOBVtPwgCYWtbOLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2x3SlsAu9+OjTuE/5cGf9zx5It+LM7zvftjC2wJzXoBPCTDR
	bv5wM/b0vn3zt3YjdFhnNhd13U8xdem448oXv9fsDVyzkFKt1okSn/Ixas6XyBs6bc4=
X-Gm-Gg: AZuq6aJHTCCkXmBx7VzKrGKjK2eEZSE9pS6+tz6wolRgeT9ddri8letQ3rRGiRD/alL
	jls7xJfQwfFEdVlFn7P76G4/uXtV2VyZU7TH7S4gFy80msT0RoBh20qwhTmbLDc4O5KrKaYMCtg
	ztzNdpwpaUXBgkiCz4OsUzU/cIlJoMEHh6Dto94MSgHSe4chwJ9Kt2dTn6MfEKR2uIw7b1PTste
	JL2yb56FGrNpGk+pJe4ktgT2/vU1J9XxZKhTrU85PEyOo2NORE6//97kZdZUcHtXgFpFP2pvJdW
	1CLGrQQE6j4aOx3CN2Q9IbDMEnVO1/yb9748+c7IWbzXj7WxrSFhdB51SxPGNXxHVvbJGgl5yQt
	QNRDZXhctn0GSkzT+Y5DNkRgI8jycjU01N56y1UYG11jk1QbfsIM0IKXW1V3PdCQQqMWpBoooqJ
	eQA+z1vL4oqlQ=
X-Received: by 2002:ac8:5716:0:b0:4f4:d92a:7be9 with SMTP id d75a77b69052e-502f770bbb8mr26927421cf.16.1769137250923;
        Thu, 22 Jan 2026 19:00:50 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7ec4f7fsm9479781cf.8.2026.01.22.19.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 19:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 22:00:48 -0500
Message-Id: <DFVMTC754CLG.13D4ZT20QISO2@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <etsal@meta.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
 <song@kernel.org>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH 07/13] selftests: bpf: Add ASAN support for libarena
 selftests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260122160131.2238331-8-etsal@meta.com>
 <161065237f7ad567f93be5052ac9f15673909e5089388f71fbdf8ddd5dbed49e@mail.kernel.org>
In-Reply-To: <161065237f7ad567f93be5052ac9f15673909e5089388f71fbdf8ddd5dbed49e@mail.kernel.org>

On Thu Jan 22, 2026 at 11:58 AM EST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b=
/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>> index 2e4c0830fed9..4d7db66e75ed 100644
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
>> +	is_asan =3D strlen(name) > (sizeof("selftest") - 1);
>
> The ASAN detection logic compares against "selftest" (8 chars), but
> the actual binary names are "test_libarena" (13 chars) and
> "test_libarena_asan" (18 chars). Since strlen("test_libarena") > 8
> evaluates to true, the non-ASAN binary will also be detected as
> ASAN-enabled.
>
> Should the comparison be against "test_libarena" instead of "selftest"?
> Or perhaps using strstr(name, "_asan") would be more robust?
>

Ack, test_libarena was initially called "selftest" and was renamed for unif=
ormity.
strstr() is the better idea, will add in the revision.

>> +
>> -	printf("=3D=3D=3D %s =3D=3D=3D\n", "libarena selftests");
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/212569=
73563

