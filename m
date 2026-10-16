Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04342AD79
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175764; cv=none; b=VexnG2ZM4TnhcWSNASEslTJhTpl6fNS6z2mu9Pmx8oxr6efvYxsTaU9Zc9g/N56X7PjZ5zDlXcWvswLS4yjG0RqKnhSWl9X5cPT14pRR27pRTPzsuA5mbolN5oKKNebblbC/I/x1gylQYIpz/GsUklVqS0IQbMiaJwiU60cv6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175764; c=relaxed/simple;
	bh=UHI1RhtYGQef+Hnl8xvao754eLHDmAqBl8wOTDDyFUs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=g9Aax4GXbJe2aReX1oKdOgFzDgDAJFkUKyfoP3qFe2tQ8e+jmDYFx4bkMRFzJVpYUS+qbrbvbTLgDetrlO4eqyyp6qjz7dTcnuiu9ZllwmE87M06TOpbKr8jaTjfRckYeKaxCWFUc6Y+OrvEvN0M+9a9H+F7UHmu482HmReIZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNL1YHMD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNL1YHMD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2dd9cbb661bso1241115ad.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175761; x=1792780561; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nuY2v1ppZTu7OOAjxLm6de5JB+RdUhZ3i5YpRxbk/IU=;
        b=WNL1YHMDqZSSoB6FTDaeffGOoLegOzvuoshVOf7Fih39HoK1VZn7ly8WKXaEfxLyln
         nIWCv38psi1lim/p/0D0OJMcn2Wj67sscL0Vk6B7m9FW7Jtm3yV8f/atNxlcbn33ZQel
         DIrRz1FxCQtgf1OfCG9YRgxfpr/MRkXXzZ2Fml7uL1k+uH7WQP98gmfnP9YkMYP1rwGu
         sIwdfpl0X71N3Cgtx2+KFPzquH5f4eV/WHiY+EF/ive7PjBFK/DHIbM1+W071C7XLaOy
         dZ/p0+FJTJeAPhTgLQx9cuV3aNWG6CJVCZ0a4WV5+1Sz2FHc8S8ljPgAxd+drHPa0MpW
         jtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175761; x=1792780561;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nuY2v1ppZTu7OOAjxLm6de5JB+RdUhZ3i5YpRxbk/IU=;
        b=YVNaAV4QiGLwNyLf5QSX34fHR/M3oPjJHrNsswG5A38XpQ+hyxOlfypEv8ao+5oh+v
         Y1FIlcEXXGCFu0lEC6pfgv3hmvdyR0GSr7E7B6A1hfOfdTpNXSLGXiCqdvoryPINVKnK
         IMLmCR1aQIbfXPMiW6XI1DXcoFERhbSbyXlkSklwuseoDOBnI8UUfzgTssuOq7ZuiiN+
         TzwY7qe8pGx+ftF4cVbHOt2LhkEK9RFihQlv8gMP8sWkvqGbSton8hNaDjxCmnkg7kdc
         tb7csNdXQCN8JG4kQr3A4xosE+dz/Hrgp0/R/dTMhrQd5aIBbrfTt3yatrc7FN/TvywM
         M7xA==
X-Gm-Message-State: AFq9FYLd17JRew7aDpgdCXQEczoA2E1d537kaMDjBCgKr/ADCcK/wuY/
	hPei6O3Bmb5CXZDmlDTxM5HIeXo0vMUZucnUCOeIwijE0YXcxt2dSvUw
X-Gm-Gg: AYBFou0ZNAZQyixpGJWzXUe2zVfSqcmJq3pmr7cYvt9i62t6kUD6U+iGszoChOMgNuK
	dDT/Uk1y+7TCj1ZI+Y6fCXpwXOen0NzldZ2CUTkzBSfbliRdIK2sKuzj7z+HPNC/PMUdbd8h+Gv
	QFW8sdKT2QiR8BCKNwCZhpmTbHhSMu2y7kI+3vjsbtrDMOCn2ur0u5BTRQozDkhCH123b27tUmE
	Tt8EbxxaL1duhp6Nqyg7UvMidAJrBPmF4VuAQUOhazwspeSwjl4ff5NozrXOEjOfNIFUPsNbBvA
	lfYrIBPrTVXflgj8ZCpazFJYUgjTHhlFOwLvH6AQ/EDmqc+5cAm4NjdsQt7xoYJWszmz7InhMpw
	HRB8DBlMtE+jIO3OZpEoM89SZQGN+ywis6P3WE9IbwQrC4xpC6Ny3klfATrBiEEskPGyTRkYRgv
	jk2KINAVQtLX5GG6Tycs0rAzO0UcykTzrckCFFY8NmANtlR9IuyvA3xSI12pwGgiGJ5kL3fQ1dy
	79OsWkk0iY90qIb9xZBeCmPtUlCT9Az+3bXNBUj/FOoaXWGkRnr8ZUYGMM8QzC2nqiJ4fV3DXAG
	qyQ=
X-Received: by 2002:a17:902:db07:b0:2e9:628d:e9c1 with SMTP id d9443c01a7336-2e9a69f8df8mr7920485ad.26.1792175761184;
        Fri, 16 Oct 2026 11:36:01 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d51a6sm14945295ad.12.2026.10.16.11.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 11:36:00 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 18:35:59 +0000
Message-Id: <DM6HAA1FCDCO.1V38UFFVZNV16@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Run the enable_stats program
 with BPF_PROG_TEST_RUN
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <20261009-selftests-bpf-enable-stats-inflight-v2-1-691ee379e511@gmail.com>
References: <20261009-selftests-bpf-enable-stats-inflight-v2-1-691ee379e511@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 10:04 AM Qiliang Yuan <odys.yuan@gmail.com> wrote:
> them. As a single run can be shorter than the resolution of the clock,
> run it until its run time shows, unless its runs aren't counted at all.

Did v1 fail anywhere?
It passed BPF CI on x86, arm64 and s390.

> +	do {
> +		err = bpf_prog_test_run_opts(prog_fd, &topts);
> +		if (err)
> +			break;
> +
> +		memset(&info, 0, info_len);
> +		err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
> +	} while (!err && info.run_cnt && !info.run_time_ns);

If the kernel counts the runs, but not the time, this loop never ends.
That's the bug this test is for.
check_stats_enabled below can fire only when run_cnt is zero.
The watchdog of test_progs won't help.
It does pthread_kill(SIGSEGV) once. crash_handler() prints
the backtrace and returns. Both bpf() calls don't block,
so there is no EINTR and the loop keeps going.
The test has to fail instead of hang.

Run the prog 1000 times in a for loop and keep get_info as it was in v1.
Then no need for the comment, and check_run_cnt_valid compares
1000 with 1000 instead of 1 with 1.

Also pls don't respin in 12 hours only because a bot said something. Wait for people to reply.

pw-bot: cr
