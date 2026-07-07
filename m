Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CF19CD0A
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383476; cv=none; b=KwT5HA7IjXEQ1gViSlPHg0Ddbvt7L6d33CGnHf7n8/rIM7ki2qeUybQb6VP4BqJbP1+negRrdJHp+BK7EHtp2NKYb8wr6t5qfg+4DdHa+OUfoKR0AWV+aeA/sMpyv2INJuxBZtEDNzCy38HUha+JbFmR9JIUn6b32zsYUCf8m64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383476; c=relaxed/simple;
	bh=af72MIiNPASyMrPenWUlckSQNn+OURdtih1H9LpKlI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuqzwfvADIkm0I6+QlD4vj6g+jHBkzAs0cRtZTfi6Fm/EysjYD9GnKwBH+SmOsF4HFmJMtIJ5ykySKniB3TiO8xthhkkGtOnAOX8WJoVb9BjgMKe4BmEKh2+rqrvnfRwSwBgqv4SqovjbPYjwvsV49QVRg3QZBmLnK3ZH4Qr4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2UChFPG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2UChFPG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3500106a91.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783383474; x=1783988274; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlYk0sNL0UkMJvtmh539AMWShHtruvV8sV0IdItG1l0=;
        b=P2UChFPGk+gSselBw1l9QAitcDVL1UVr1rYuMfJAJp/H02DWIazkdCjUUQTqDHR+wE
         gsPUm8oUz0Zdppyc1D7a6HBcy/zWtuvdA4up6FOx7SN3MJD5HSFAoBCvO9DumA5mg0Lw
         a42EdP/KKa3XN/SOvd+wF5IuQrDFnPPrZJOouz0o952YAmIypE1+6eyCRtyWTv7I0n+R
         u8tKEWp751lwecHjOhLXsn2Q/pxCtAVVWWyCaIYGu8wO3+zG4YOwwSiEhFgeKp4XFoo+
         A8LwOVhCR0g0Os0yfMwZVSfh4fhRqxbQa51HnhL2FnR8wYxvWBW/MSwOnOfutcQjzdK+
         f0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783383474; x=1783988274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlYk0sNL0UkMJvtmh539AMWShHtruvV8sV0IdItG1l0=;
        b=gGeBkpO69eg3t+EhUH2ITDsBXAzjX9stjFo3LHsp5c7FbxstjPT8C5RQN4t8claiR1
         xWcnf8ko7CmVKSArEM7jGufVLbg492ma2LXxtZkqLOwrOPf3MB6WmjyHqRwgRUJFeRCL
         eqFF4w7Ir4g+0nSB4no4qaZx76d0q10+5119m2zcYMKENk6AakRBhLjk6T5NstUUWRb6
         tDzOob1tpZvTmGSC31vl8AP4ckf/yxEW/vJTrxbvrz3L6nnUY3iiB2QlnlMvTCoSbVer
         3xNLBJT6BnDsHiyus+1zuQkcmyu+CAfwirvjD2axL6CdFp4wqhVbpmweM9/iwtVb8sTi
         H9XQ==
X-Forwarded-Encrypted: i=1; AHgh+RpW82BDPjLHIQYP12z+3Ps49W+AunuBhi1eDUD/UZ8Q7qW628HlmlgfDR4pU/ViUF+Su54=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfa/Rn5xEndEsesXoGqTxjQanuZx7Lm9J3NSU0r4GdeeLiBYPS
	UKmPxsCCl00N6PfSkyhAWuAkhbBVruovZ6JIeEfclS8zK5Ot8W6BJWYb
X-Gm-Gg: AfdE7cm70Y7MIaDSMra2SrqZqyJ84AXijwdROobEFkLvEJXUaUqSDq4SVrJpTipLIuw
	+SCIfDgcUZnKq3994uqW9wWHKQY4MKLsE0/tf+DGeP4YmcLbdEore7vGNUnqtE4qREEtxlWTqlZ
	aUs1xU0LCASNpxEnvztGm4oBu3FYJVucTKMUbax5Olpz+Lws6/tinbZa9H/MOIXPgrR1/XVKaY4
	ds5WqoAecyRs/MCTqHuHCzW4aUV0sHgN9BGVF4Se0s6oC16VwZ+CnmTFa1kTvHEiqq/FBuF2uQf
	WwEtnA9yQXB7grKeou4kA7bQI3NiRkZA9cts+JhJ5mB3I7S7wXv9WQJpy6aWkp72b5Cqnp/T9Uh
	AuxqNbneRYDutaIiJHrlzJjdcH1Qz09xMI0z64Xd2BQBedo1ZAudraAamr7C4k0R5pzBHI/HaBg
	j4wDbdhjhQ7VFFD4OiX2O2xlaOud6qgZdYCOhV0g7Bu8785uI3XdaakaaP1rLAo8d8Rue4Uw==
X-Received: by 2002:a17:90b:1845:b0:37f:9cdf:f0ad with SMTP id 98e67ed59e1d1-38757d76999mr2730666a91.28.1783383474243;
        Mon, 06 Jul 2026 17:17:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:275a:65bb:602c:da1d? ([2620:10d:c090:500::1:7696])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a89a89sm1783645eec.20.2026.07.06.17.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 17:17:53 -0700 (PDT)
Message-ID: <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: compare BPF and memory.stat memcg
 stat readers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ziyang Men <ziyang.meme@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 bpf@vger.kernel.org, shakeel.butt@linux.dev
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>,  Shuah Khan <shuah@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, kernel-team@meta.com, 
	linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org, Shakeel
 Butt <shakeel.butt@linux.dev>
Date: Mon, 06 Jul 2026 17:17:50 -0700
In-Reply-To: <20260704045617.487664-1-ziyang.meme@gmail.com>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-03 at 21:56 -0700, Ziyang Men wrote:

[...]

Hi Ziyang,

I'm a bit hesitant adding 2.5K lines of code to the BPF selftests,
as this code would need to be (a) maintained, (b) run at each CI invocation=
.
Hence, the tests added need to be relevant for the BPF sub-system.

Regarding the benchmarking part, as you state yourself:

  > In my testing (a 60-CPU VM) the BPF path is roughly an order of magnitu=
de
  > faster than the per-cgroup memory.stat parse for a whole-tree scan, mai=
nly
  > because it avoids the per-cgroup open/read and string parsing.

With this, I think the benchmarking code can be dropped altogether.

Next, the three memcg_stat_{reader,churn,churn_percpu}.c files share a
lot of utility code almost verbatim (e.g. tree definition/construction).
Such duplication should be avoided.

Finally, from the BPF point of view the test exercises the following functi=
onality:
- kfuncs:
  - bpf_mem_cgroup_page_state
  - bpf_mem_cgroup_vm_events
  - bpf_put_mem_cgroup
  - bpf_get_mem_cgroup
- main iterator logic.

All kfuncs but bpf_get_mem_cgroup() are thin wrappers around mm/memcontrol.=
c code,
all kfuncs including the bpf_get_mem_cgroup() are already exercised in the =
selftests.
The iterator logic itself is covered by 8 sub-tests in the prog_tests/cgrou=
p_iter.c.
Hence two questions:
- What do these new tests add in terms of tests coverage?
- Why do BPF selftests need to exercise the churn and churn_percpu scenario=
s?

Shakeel, could you please comment as well?

Thanks,
Eduard.

[...]
