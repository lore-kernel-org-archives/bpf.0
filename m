Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541197;
	b=Q1BDVpKE3L2XI7AtG2XXPdSc1XEiNlLbfwc+xDkudO4P0Js7XhC64+DYhg/POQTxIny+
	 00Yc3rMpqTecujCft7PchBZISZIT7oJOXGK4UQ9wsJv+3VAgvR8FwdWDhC9U6a0hiAXe4
	 SM1Kzq2A5fw4nopmU+wG6TfDBtUyEJzX+OO2KcJ8dR0yu7Yg+iWpkMRM96SRYh7vcqBRr
	 fVp1a8z2eAN7xWDxDfQI087Q9FrQKBwlXpDHDwcIsFPYVZpQDz2Cx1/uHADzDy3NId1v7
	 efj2DtAe1tBnarMpa5YsaShMw6Mb1TYpEbWbiVGA3rImz/TQ7VtUGG1QcTYPCvW3dPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=E1iiJ2Iaf9vCRbFh4+GEtLtF5DOBjcM+TmDaqT8MSR0=;
	b=Cwup5AnnxdSQaaUz+hSZb3SZPuBgx3b+wnEObrNz+lwzu3YD6i3UzKVbGE2wYf1HaKsY
	 8nkyYpexWDjbBeqBtqQjumNLl+lpI0OYuajx1dAmRhtUPEG/1bygTEAcJanBxXfsYYHBg
	 jNLVwmfYHydFx68aLA+1J82HyJSw7P/z4RiMkxg73dLNbL2sRzxV7/F64Tzh3Affm9VpJ
	 GGCboMyAwJTRYx91auwVNgq+BvnSxmJlgz5K2OoRZrxfkZ24Dky9wwGQn1RswZNS5Zyqf
	 ZeYK/w6Kr7IXpph29yxnvR+5V2p+Zt+knJZrY0q03vhF79Wj7m5zC1m4wM40oLznfKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAb0+oEa;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE95606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CE95606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAb0+oEa
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so744807a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541196; x=1793145996; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E1iiJ2Iaf9vCRbFh4+GEtLtF5DOBjcM+TmDaqT8MSR0=;
        b=ZAb0+oEasJXyCZpB7ctmdzy7sr8Ks8sPIq0bdo+o1E10yQFXy/SxYm2IC9tOO8pXPm
         SdlRblPGjMFVouXYkb6bT3In5+MPBLzQLmriqmsezMqRbNplfKsQQ3ktaXfMzR0uBTu3
         Zy/xwflO7uqjKEINmiom4gYaJX/BD5Hb/zf9wjLNMSuqYYuP9rNZiBvrecPpujkkn10s
         HaX7qNNDeAffuI5Rfrm/516dY6bLAT6qKyesjfM8rEY21rGI9hZmYCOljptH6jKQY/va
         XuljWxOBmytn1c/idJOEex4mSC8Qj8N1TUnrrfBVqhRBvqltGFSXLjH9vE4+AfUVj31+
         pwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541196; x=1793145996;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1iiJ2Iaf9vCRbFh4+GEtLtF5DOBjcM+TmDaqT8MSR0=;
        b=anXyvPC70xlwiVi+WGfwVt//pK0XQwk5LpDgBWWb6jMq6i5qzsrnq/VZig+1JJTDHL
         7LK+EsYGJHZRNp30o61wBzSR5qzFBjkwuBQa9RpocGnX5ndOwFhOUO11ld2U+30zkd8h
         eCnp8c66UzQltEHvqn1WP9v3e/MTbRmkVdGgFq/ExqBAkkzLp4qdUf2a/udwuioaJ2ne
         j5ZaJ8TPDqzJUdaAsTkB/hHiZSYELcIXf8ZGUxodN6QsIex4L4j2F8nf5rImEMvW9MrB
         eZ4lLS/Sfk/Lx6JbPiM603F3CXEGL4cZikwWexf0Qtj+ZQnSMWCyzNBBiB6Sswuayen9
         1NFA==
X-Gm-Message-State: AFq9FYJwinceJwy3rEsQJzMiQ8rcOxAt0ZFH3k+993HzbcI6vCxp87Ah
	pRt67PqfqpU8ws01EWsh4AnyQhVgwICIr0tEakFfukPnmRAOCZjSitMJ
X-Gm-Gg: AYBFou1N3H6sFKpdiLbQyBkiGfWoUMJg8ULiAzyL0aZgfUD2phrG9qqWJa406x7CCbe
	ZCzZgp7vCwsJ9z6CB57b2OeeIJ2znG9fFGdbqCcLLfEWVPVySvL5Bo6WGBzBczApkhZLCi6/cS9
	07kLAzkDHZRdNVQuTUqBsxfmAv3wucesKmNxjY/3DFhN00jUGKuYkMBDE1kJZ5O01HBlNTB2svB
	h35oaUahLSrGh6UxFFb+Xgc/fUdKKBiYcodfyNsL7bwCmkzbFvifgJbE+tJH3F1nKeUN3SuUZCO
	H2o++varjMwDdWw4a21Db1WO+63M1GPzxxc/esw2uGuaqkP1WpUnUO/a5GfEeYJRnQd7MJa0BdI
	4ScFHI82nlrG632/gxcLs25RyU+K/oaiXzy3jUdO0rFg3Qq4XiAVXW74h2pktdwytkuh77z3Xco
	z2OEe8xaXMYcIvNlUNlRmffYYLxV9wGdN9pOc55XAVh9tX56RPxPDZyqnDI9Jxn2A20sqHeon2Z
	vuB+0xejU/t6hS20TwQ/MKH/YlyAgy1lvTzpX2jDxiyKpe13conpdI5AtJcCBkinao1LohiFloJ
	FbGEzF/aqa/s0ILiGzTHd6H89rDZ4T+p2EbiGeuH236bz18kuHmv+ILO87Gf
X-Received: by 2002:a17:90b:55cd:b0:3a0:eec6:b065 with SMTP id 98e67ed59e1d1-3ad86e96c31mr264931a91.13.1792541195774;
        Tue, 20 Oct 2026 17:06:35 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80303302sm1506747a91.11.2026.10.20.17.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:06:35 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:06:34 +0000
Message-Id: <DMA2TKIVB6J4.2UF472OAJGB62@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Run the enable_stats program
 with BPF_PROG_TEST_RUN
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261019-selftests-bpf-enable-stats-inflight-v3-1-e7728f5b061a@gmail.com> <sashiko-outbox-176554@kernel.org>
In-Reply-To: <sashiko-outbox-176554@kernel.org>

On Mon Oct 19, 2026 at 2:57 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] selftests/bpf: deprecated CHECK() macro used in test_enable_stats=
()
> --
>
> commit 149e144806feffc72e780046d3d7759e157ee137
> Author: Qiliang Yuan <odys.yuan@gmail.com>
>
> selftests/bpf: Run the enable_stats program with BPF_PROG_TEST_RUN
>
> This commit replaces attaching the enable_stats BPF program to sys_enter
> with running it 1000 times via BPF_PROG_TEST_RUN so that concurrent
> syscalls on other CPUs do not race with reading run_cnt and count.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/too=
ls/testing/selftests/bpf/prog_tests/enable_stats.c
>> index 75f85d0fe74a4..5b9cc119d072d 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
>> @@ -5,10 +5,11 @@
>>  void test_enable_stats(void)
>>  {
>>  	struct test_enable_stats *skel;
>> -	int stats_fd, err, prog_fd;
>> +	int stats_fd, err, prog_fd, i;
>>  	struct bpf_prog_info info;
>>  	__u32 info_len =3D sizeof(info);
>>  	int duration =3D 0;
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
>> =20
>>  	skel =3D test_enable_stats__open_and_load();
>>  	if (CHECK(!skel, "skel_open_and_load", "skeleton open/load failed\n"))
>> @@ -20,13 +21,15 @@ void test_enable_stats(void)
>>  		return;
>>  	}
>> =20
>> -	err =3D test_enable_stats__attach(skel);
>> -	if (CHECK(err, "attach_raw_tp", "err %d\n", err))
>> +	prog_fd =3D bpf_program__fd(skel->progs.test_enable_stats);
>> +	for (i =3D 0; i < 1000; i++) {
>> +		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
>> +		if (err)
>> +			break;
>> +	}
>> +	if (CHECK(err, "test_run", "err %d\n", err))
>>  		goto cleanup;
>
> [Severity: Low]
> Since CHECK() is deprecated in BPF selftests, should this new check in
> test_enable_stats() (and perhaps the surrounding checks in this function)
> use ASSERT_OK(err, "test_run") instead?

bot is correct.

pw-bot: cr
