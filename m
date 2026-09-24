Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818140F72B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267096; cv=none; b=ll1L+/iycpEg2j5zu9SApg8S9De7K62RpLampAwbDKzPbkixVOFDx+1056lMXg2fJBNjacPhbloeRksxs2WtVCQOnKkxjVEt59pVs0EXJ0oB9uHpC52DXRA1bfyCumEPzNGxLGTmt/g6gdj1BJSbcFSfshAYjT4E0Ux6VWArL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267096; c=relaxed/simple;
	bh=440h9dFKjB/gL6Kt8Wwp2sOdSQZbYHU2D2i/qlxYifE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=aqiOHLTVtSfm2BEhn+PI/wzppbv9874ypgx8qZDMlIcHjIGRRzbZMPWDnNlbo7BXkYa84kdNvBAe0A9aCviG7iVXLgpygEvkASKDkgCt0THIMeHZg/dwjPgZiYhCf+bv/bdQWmLUnu45EjrRq/w8VzBLY7XU/ciabWxLnRLyl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amgVEXlD; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amgVEXlD"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85e68bdbcc1so25191687b3.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267093; x=1790871893; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4EdeJyFvDx7/h+uSzbqlt1nBcvAWTDwgRsH1W939sSc=;
        b=amgVEXlDw3WXRKkw5jFf6JpviEeeFfSBTxlJqyFOUZQQcq75eahVQc4AgIH9Y+x964
         LXSA+pPeDYsb4frucnXxAQClFs52vbiIi/rdKjiGB3NVsxadrU/FetTvPESDGytbSQ+d
         EzIRWq6/pPGSJu4kKHNl/ElAI4NORTdY+jsRLTgMkeJAk/u/KrxIdJGEr5m4Kp8+EoAO
         6MOOCfrZgcGU8dL//sUrhvpl9d+f6uDvbA4sTnrILiSLJcF2L5qfXfO5/gZDkGJHyxCd
         dR+jpg0YePr46Zy+3kZBxFB0xJYtKcErl89nkXDiveIYLHiDkIVnD5jSoVtBpi2WjZ/C
         c11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267093; x=1790871893;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4EdeJyFvDx7/h+uSzbqlt1nBcvAWTDwgRsH1W939sSc=;
        b=PMqvMYMJAmvDxeMzVtVaFwYd83HWDVsbfCjEAPty6a8/VGxypL+UylBTnbE1urIpuH
         pJ7gezjiWCGlY7uiUMGClY0RxgBb6KFizPHKsm3XmxxMhLldnwWXOuh8sy8JErQCp1Gk
         KD5jpSsYjTUkCxatk80h71C/JVxOnavWybCYw7OJCN0BnOsudUWVla6bwodjcFilXkBl
         9K6TP46164RVhljADLb25ZlhNobpd1gPYwdVjQX+QNNKorQgcQhe3/dR98h6bb30wdFC
         UdlfbKkMJcPaEhfaBX0mC89qLLNjadDHacHFyu13aruDZbAMa0Sk69NArgw3v2L3BZn7
         Mukw==
X-Forwarded-Encrypted: i=1; AKwUvBy72eZIujiHpmVSn0ywxTVmLupvfYnzDkzJgO3vDxjklSfdr4UtpqETX4CmH9SL1Qwj0qA=@vger.kernel.org
X-Gm-Message-State: AFuF++kTas0h3mJuLP6sqfFdd6VOL1qG0j3GIBdzZiKxO694Gv3GJmmh
	lGXjUFc+u44a4chCfpq42X5ebuEXxC6y1P7TaehWDjYx+fTRUkXdHEzV
X-Gm-Gg: AYBFou09f+ZzTNFsLEyudnPnoBgr1vdcpTnB199YKWhlelDng/1sEQWlI+QXja9RBJg
	YHo/RoXu4macokrYXyXbwncN2KWKB2EsPZly/ni3yB4g+YrDGvbK5a12RdmlzFhq5gmFke2YkWo
	aNJve6XDvHe6IJesPLDxhI0Riqz5XT8lxZoXju64mp2ZbBDpdsHJf6+exj6fikPFNE37MGemRmZ
	QUGQHN3+EhjD02iOS99P251z8OXaT3lkgXHGiK0Bn462Irfgf4+fXq3crfPDUWPTrv2ccO/66yv
	+Bj3XlUvvcHv58iHQ6KNdbGByBi8/VN/Pia/WmSji4npMw9Cya0dtbXbg23JN4crizkbXsGe8/Q
	9rjgU/gdcYcba+PKeKAcZAkVW6WE/lx0/emOYOdTxA4KEnSrOebXynFw9jXjGYg0tjnhXBVFk1E
	VuFzC+m+3b1xzfyAzCXirceEADPn86s+x0ilNeFAT1/y310eqasSEut2JWK59sTopgd2Relm3Ke
	/nbcMlkYNZiYOMnhEq+ZFzIHTKQWA4GH39gK1CKCQzcCNEiknmmdCeDTZZBQ1VBCG54cHFdFwse
	czg=
X-Received: by 2002:a05:690c:39b:b0:89a:63da:cbe1 with SMTP id 00721157ae682-8a649f614eamr21784567b3.39.1790267093494;
        Thu, 24 Sep 2026 09:24:53 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a652715b65sm10602237b3.40.2026.09.24.09.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:24:52 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:24:50 +0000
Message-Id: <DLNOPVM33JL0.4IW7LA889QQ2@gmail.com>
Cc: <qmo@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <kuba@kernel.org>, <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Don't report an empty map when
 key iteration fails
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Maxim Skokov" <skokovmaksimevg@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260924160732.485650-2-skokovmaksimevg@gmail.com>
References: <20260924160732.485650-1-skokovmaksimevg@gmail.com> <20260924160732.485650-2-skokovmaksimevg@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 07:07 PM Maxim Skokov <skokovmaksimevg@gmail.com> wrote:
> This is what every local storage map (sk, inode, task and cgrp storage)
> gets, since their map_get_next_key returns -ENOTSUPP. On a
> BPF_MAP_TYPE_SK_STORAGE map holding storage for five TCP sockets:
>
>   # bpftool map dump pinned /sys/fs/bpf/tc/globals/cilium_lb4_reverse_sk_v2
>   []
>   # echo $?
>   244

cilium_lb4_reverse_sk is an LRU hash in cilium. It's not sk_storage
and bpftool dumps it just fine.
So where did this output come from?

[...]

> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")

That's not a fix. The exit status was non-zero before and it's the
same after. Drop the Fixes tag.

[...]

> +			p_err("can't get next key: %s%s", strerror(saved_errno),
> +			      saved_errno == 524 /* ENOTSUPP */ ?
> +			      " -- map type does not support iteration" : "");

Local storage and ringbuf return ENOTSUPP.
Bloom filter and arena return EOPNOTSUPP. Queue and stack return EINVAL.
None of them can be iterated. The hint is printed for the first two only.

[...]

> -	} else {
> +	} else if (!err) {
>  		printf("Found %u element%s\n", num_elems,
>  		       num_elems != 1 ? "s" : "");

The subject says "Don't report an empty map", but when the map has BTF
the elements array is opened before the loop and closed after it,
so stdout is still "[]". Only the line on stderr is new.
With -j the error object is printed inside that array:
[{"error":"can't get next key: ..."}]

pw-bot: cr
