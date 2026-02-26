Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723622127B
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118120; cv=none; b=c5PtiEiCWfQUcLAzdBWgGT21JUd9HRI9iSzj4MG2t218Zjo8/N6nwchzI4TLQqG8mUXN5kdQc98beG8OEswaVP9Ndr7TBwjCCw5oVz71hzKo8WaZ+Aa55Q9pmFvDkHxJy1GKVpSh3Zi73Av4qPzLboOHPCz6mt3Zx1pZSdB1dyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118120; c=relaxed/simple;
	bh=EPOgpY7qfE74IS9r5PQZ6CfLK6gZgb4B14BVZERxa6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bqsLt8rXOBdIvWej3Pxmvt6xwDX0fvYKhJYYQKhoUiZ7RkF9CrEHCtBWL3yZNbWEYnlC75dD3XRliWmkBSI4stvp9K3hsqpxUemrgryWARHhCQw/gboeXkvAvAqmm4uWSzNWsLY4FgJo8sBaa0LL3h/qoHf9+vb76SqOI79AzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO2ZOyui; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO2ZOyui"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso8118055e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118117; x=1772722917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI6/1FhqyJ03G1hV3ALjmIdk1suagRQbbHMbWSVeSlQ=;
        b=EO2ZOyuiH9kObA6V4yyR7uP1t69efFSMc51LPTLUWQwK9//D9WRjcjLaUsGvPNdsET
         NWOvHlnM/mFDFd22l8jHDkK5o/FTtjyf6LRY7rUeXKzljUfbiKrMivQeHmAFOAAHlD3y
         5012kt9/KCVXJ8OZ8v6xkHmdFz0soBhLdr2Q2yt5x6t5Z4inHJFc+ROrnLx0sOFN9+z0
         pUYR1BmXKPqqqYTdq0v6Yq+UxHcE3CPhA4fzhwJ+lz6DITQdlbZsxwjau8jyLi6l0woD
         bMJFJhIQCGCmCJ/WilwTR363kpZKbcRaqhy48D3/zn5ygMMvgwp71kEf0YEo2TnwC9My
         jAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118117; x=1772722917;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yI6/1FhqyJ03G1hV3ALjmIdk1suagRQbbHMbWSVeSlQ=;
        b=egkXFQZrwlI9XPMqdDS0GVAR40eDfPtLqhCUcMGOtiofmzIasK/TZyxbHgKBWNbTwN
         AYlQyCsJ7wn643B3Ttz8IJvllaQVM7GgXE43z9/7A0UR5fi71RmCVLuS3LXkTqN/ZgG4
         PU7p3DMDKQ/LTJ/Q7Kk+9U7sgWf8EQuYoCYGbphCV1Q6REQrZwxm9HRlczGBCFJBtWU6
         9k0OBkHdnzB/2GN5eDQv8KF+pwSDhq+81lz47aTbqciKmn/UiJpvMPzamQO3SboJvjaz
         8yKhxaTmevHh+KMznhLIjwcKmEss9YEg/hLlwi+Atf3pbgZCzz7EG5g76UU6hXCcirR+
         Z68Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI2Dd4D1Xgpu//r54ULaEeYZ4TUpntN8yAFJJGPMivR/Y4MAVchM2e1ueNUFva+5YCPjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGuJUmOwB8MMehKFGfhy0WakutLborUURSMxmQZbQZXDC4tv4
	kbewNRKweDxaXuWyaO6KA9tEqm2AdHH3WTS7MIQd4upwBIhZ18n+mrSL1RcnXUGVSIQ=
X-Gm-Gg: ATEYQzx3G2312ThSu5YtBNTv66blfxmTj8wITSk+oraF8UvStXZDCbC4lPWOOChDNYh
	xhxPkyjuNFVSIxZ6kMAXQL3Cnck+6XxTRkizCdlnRYGXSwGJjR+mJP6MSW15Fr6ANRxEnfAX4Ru
	mHUi34wayt81HkA/Ner3j3IAbaFsVyY6qIiV+j4PkdAB2cyAuY9Ld5SnlQeCKOh13Qjc4l1BDVo
	0SgJT5n6SDvzFpV+9bu83RTHhQFuEADsLj7ocJOzGeHrtesOkbvX2tfEbifCe9aXy8zPazMy8dK
	XUYKQjPgsmTk5/kKgQRmkDN3qonv4mvu/rAZB43ScPx8X3fgAEnXwThiV/mcGaZpdjxSGrMwhWJ
	WIZDlitb2VxnjSg3rZN1Fp8ZWBirkjetta23GrPixk31vLUOwoXfsEvQQxQVD9t+jpTTONjmQJp
	uzowMDRLAROaxxr8d8uZf21WmGt+SvmA==
X-Received: by 2002:a05:600c:4fc7:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-483c3decaf9mr43090825e9.22.1772118109848;
        Thu, 26 Feb 2026 07:01:49 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:5405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9a5esm91724925e9.4.2026.02.26.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:01:49 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>, bpf
 <bpf@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>, "Bastien Curutchet (eBPF Foundation)"
 <bastien.curutchet@bootlin.com>
Subject: Re: [Question] json parsing and bpf selftests dependencies
In-Reply-To: <DGOTPHTTR5ZE.Q7ALRR86ZZ6N@bootlin.com>
References: <DGOTPHTTR5ZE.Q7ALRR86ZZ6N@bootlin.com>
Date: Thu, 26 Feb 2026 15:01:47 +0000
Message-ID: <87ldgfpmzo.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> Hello,
> I am pursuing my quest to convert standalone bpf tests (from
> tools/testing/selftests/bpf) into the test_progs framework so they can
> be executed automatically by the CI tooling.
>
> I would like to continue on the bpftool tests, especially
> test_bpftool.py ([1]). This one involves quite a lot of json parsing on
> bpftool output (to validate that some entries are present in the
> output, depending on the used command), which does not seem to be a use
> case currently in bpf selftests. The first tests may be handled by some
> manual parsing (eg strstr'ing keys in the output, that's what I've done
> for the recently converted bpftool_metadata test, see [2]), but that's a
> bit fragile, and there are more complex subtests for which this loosy
> strategy will get even more fragile (eg
> test_feature_kernel_full_vs_not_full generates json output with two
> different commands, and tests the diff).
>
> I then face the need to have some proper json parsing in test_progs. I
> kind of understand that there is a will to keep the dependency list
> small for test_progs, so I'm asking here what could be the best option
> for this:
> - is it ok to make test_progs depend on a new json parsing library (eg:
>   cJSON) ? and so add the library to CI images ?
> - or some implicit dependency on some CLI tooling (eg: jq) ? and so, add
>   the cli tool to CI images ?
> - test_progs is reusing json_writer.c from bpftool ([2]), should we
>   rather write a custom  json_reader.c as well (even if not needed at
>   that point by bpftool itself) ?
>
> Any opinion on this ?
Can we please make that test_progs can be built without json deps and
run tests that do not require them, it's useful because we build tests
in a restricted container image, where adding a new library may be
undesirable (I'm not talking about github CI).
>
> Alexis
>
> [1] https://elixir.bootlin.com/linux/v6.19.3/source/tools/testing/selftes=
ts/bpf/test_bpftool.py
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree=
/tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c#n49
> [3] https://elixir.bootlin.com/linux/v6.19.3/source/tools/bpf/bpftool/jso=
n_writer.c
>
> --=20
> Alexis Lothor=C3=A9, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
