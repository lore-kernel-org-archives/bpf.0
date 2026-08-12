Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A0345CDD
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576530; cv=none; b=SdDUq5Bpgn9a85GvMWJohkcCFqipbDVO4PWc1oZjuG18ytMbqhxDUW4EOKe9fHsTDnnlDCbUXqHdVTw+QDGEmQHY25sK6NJ97RV7lwxSBVGeKLYEVOUgj41EzeXKy6TxbEbGcMDGDuxYfE3VELpf5yK6QN95/pqtkxnDXptAvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576530; c=relaxed/simple;
	bh=4KziLVdftB86fKOQP1B92MnBpbEYOU6LAI1xnpNioNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usrJssaXa121v/u3gshADRwIuFU17NMDd1i9cgMozlAX7UIkt9Nsb+NP+CjJXpICE22aCYNtk5AfKb1jmdgVrsHTE63X5B4iQJMNT/Ei+ZoeCF0nFMbfwqD076jWDsyamzeaUEDnpNw1XkqldsBz0BuIr7PYCtp3Soz4rV2FK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=janTHmfs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="janTHmfs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2052896a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786576528; x=1787181328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dqzd0lRPowE5CsT2lu8GH8pmTTOX/Z+QVxqTQGC9umk=;
        b=janTHmfsCevCKQCAcIv0s3yLjyHH58GRYwXTx1P4zvSb93titmughHf+kHdE/9KVL4
         se25y17pJqRLD7m/eG0oq25e+vrT9AXsC5d3SCfGnD7DcVsybwE0JXvaqxwIM+PHMRh4
         W14Ymmpv2okbv3Cji3syDAyfzEhfIX4bhKFOwgAziVQYV3OArf5Azo57TaIddes5nagN
         IKXKMTSKk8TYTamCKbpVfhMijnn3a5xnNLdWRb2UmGIf2vF0mlb7mOe7EXsoDuKgpqkO
         BrCQN5Zo4L2kw1le4xwbHXSaQ3TbF69sCGWQIZCl35HodKL4u281f5oNelxHxHPbkKRc
         6DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576528; x=1787181328;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dqzd0lRPowE5CsT2lu8GH8pmTTOX/Z+QVxqTQGC9umk=;
        b=QD9NhwTVkpw92XOQe+zSsbsSxcqPEZa29aecyjThuEf+uLvQkZiSxQVy8ozTGU0++T
         a29/eMjQLE+giu5sBfyFhpjd9KJnT/KcuI4hbKjTGjMcHMgOpjgmj8fe6EBhwKmHdTAL
         cM+OG/dfsAg4cXxOHT+qeaE8pQMUPzxbd4mOnJrR9bjleGQk3j55r28OHH8LTCF6Y2R9
         kP8wv2hciwOmSZAjB68OFcrWTK9g0/5aIqI5CizvciivzaqxXTpBubxqT8OX57F2Eium
         300vsXBfpG/iibpl4c2vF+CkLWoBU9oZCbLQmgRt1wfHtpBhCRuOHLFsnWawD9OQjQwm
         P8fA==
X-Forwarded-Encrypted: i=1; AHgh+RrizGbLNXWTuT8hmqV4pEjf8eByOuMEZoKT3BwP/EcrMYUcXvCggF6vBO4jBqoBhAfmZM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNMwCCUBL1jDfV3iILVvyoHaGlHSuQf2grpKt/CfK6Ne4sk8K
	0sLPcXirl7qns7w0jb7EpldNhJHv7Ri5m0DR8Bq3qBykAR9K6EOTGd7lO8ooqt4/
X-Gm-Gg: AR+sD10F7mZp+xlHnTyOC1Hrpv3DXj9YQc/GmJgsqqmnAfHs25ZW7rWJPs3/CXORhrR
	cQfDNvuqUWivuV3rY80VH+gtE2x5+igZ82LtaaB5SYMr7Mj29bWFquHv4qot6DIUkpFk4Fl471T
	0CYfZ5PuFJR8QkRATXHAfbJ2Soi2OBbPV+jSZ8xuieop8M0gBDNqMIXFRAxh9Z3V+vWsR2Zonix
	L6iltpDswQVUXFEcXrKoNKUrvprfpDIuO+ZjXK0WyyaUBRdE/hw9zrCAp0VxnVOCL1AYW8sOXOq
	PTH/tCIPo9HpXKr9Hloz4W5aJ/1GfGV9JCw18/s9TpvNt9Vv2BgfH0CfYA5SnpVfO43ADn7xcVT
	1Rb65VnOA1AckW5ldiCiQ0R6GrpOwXYTgRxtWE6QoTmMEVqJw7kFQaFq7HT0+mVfvdq6TtPFetw
	eD4O59JvBr99FeMg/W+SCxrdOUQv2cXm5AETNRFkXddkPSUUIwCkZGziEzz79Tu/Vim1M0h3s6E
	eGddqmGc7X9JHct
X-Received: by 2002:a17:90b:2751:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3931e235fe5mr2024630a91.11.1786576528110;
        Wed, 12 Aug 2026 16:15:28 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931dadc0f4sm321223a91.2.2026.08.12.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:15:27 -0700 (PDT)
Message-ID: <ed7cb5e74fa401e9d2061c8a30baa8e6d1d64776.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 10/13] selftests/bpf: Add C tests for
 16-byte returns in R0:R2
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 16:15:24 -0700
In-Reply-To: <20260811001002.2383554-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811001002.2383554-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:10 -0700, Yonghong Song wrote:

...

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests

...

> +static void run_subtest(const char *name, struct bpf_program *prog, bool=
 supported)
> +{
> +	if (!test__start_subtest(name))
> +		return;
> +
> +	if (!supported) {
> +		test__skip();
> +		return;
> +	}
> +
> +	run_prog(prog);
> +}
> +
> +static void test_int128_c(void)

Can this set of runner functions be replaced with RUN_TEST() macro and
__retval() annotations on the BPF side?

...
