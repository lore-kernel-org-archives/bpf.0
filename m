Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7B25228C
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 04:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028371; cv=none; b=Wv9FxxXCMHbiiklUMtNgn94qes/e0AOSowJSfNccVZzSX93odWT1ZsLJtgIC2kqgHfja9jXPTuHJHw/NOOQ0AFGArfIap3Gq7c19p6k4eLR9g/tWTwMrBp+ltA4KF8JLU4C7qwJFLWHb8bWokQy2OumvD5AyspAOjJU/xvg5qAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028371; c=relaxed/simple;
	bh=TJtUnycmkFiaAj3mJhUcUQu15+2rN75KyCAhaJPj92s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkhBT1PQASiPB23NqeTc9fkB3s+YxPmCEYkvcQCPhJwScgVf2V8wKW7hTXSE8nzx+UMxHNtyDdLsPCQWct9iNnb7rAnQO9tnx/zYaKW5yFKe4oVKVSdw4GrWalOG1EedygEuZRseO1lBMlKBYMQSclhV9K7h8aZG5/NlckYDVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qur0/uU8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qur0/uU8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836f34a0ceaso12245587b3.1
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787028369; x=1787633169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3KS3sK3TH9J4fhtOAZRLOoGJUvvvE1x4mW89M2uoC4=;
        b=Qur0/uU8wiFTK0U8YH8jeF6XASB5a8lK6nAcn72GH4450IJbVUNd4qwNLkaDpuQXQI
         HUTnVxvlhOymmMo5pDhWclt9JihyAHzcED5T458/ao6tlsoMRQoL7FrKnczlJ/8RzJWM
         YyAsCTb+B3O3gOOeTDCn2tZ3hBnsXmvK+nBMC0BoPmQccB5/BU9P8U0qWXVe9weM+Xjm
         UohNIdbbTnGUPRpQ3v1sPrkrIGgApGp3BSHdTdYO6J0LPmeCH8LZdWvDkeYOzKiXvHSg
         /f1Vr+EVzQ2282bBPNKU8jL+brhEPjBJnfkvS4HJGKVZPjSi4DiKiiCJ351bs2v4roHa
         hUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787028369; x=1787633169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/3KS3sK3TH9J4fhtOAZRLOoGJUvvvE1x4mW89M2uoC4=;
        b=N8IPK79lm0Wlud9KY/mK+ndvUJBrEv3mfQ1LE8HS6TguuKVGMNUWCme1iMZpeRzZQD
         8GqwyfiOzqtwxDwGg3+nMOD/f2ECIsWIKAeo7ftH9r9GeHSgj8qXUW/kEIYTqa8TMYbS
         sdV54GWjzw4oLtuYQjKQN6Vg0mUlJZPBy6hxePV5udI2pq4PfjsZ9yAbhLjzl4kvGJho
         J7EdA6BZmRw9lH+978Whxt0Kd2EceBeP1Dff6FoapTI6VSWCZCeiUTqKFulPgZQLR4pg
         8Ix+K2scj0qJFdb0sxKEqFnHCPuhK8w4gjX3hzTPWPsavxOJA/sWQ9mh2PNIHJFs3o3m
         nGsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rroux4Y4F5CNEXMAMUsHJn4Vut7nqirpHgjaByJyfZ280zmsBjL/UYadnFT6yZhBTvv/Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXC6m+q8ZLtLMMrbU+bWOlUVFOeAEmY5RDN1NrUvyX2iVXIXo
	UrzZpJdFKM+dQjZyXVSoGCNp6mC1vXAr7ETgJ5koj94Hkj7k2Tyw64aM
X-Gm-Gg: AR+sD12dW/4/cmzADzwBMA+VOurs4FKgYRG9iFiXCv4Qt2KzqCTduKRyZos4viOL1pG
	D6ydLGviRGMCMN7WUtUL1D6gjuM1NCWtKDYw5sJwJmhKfSHHFgHg6V/h3LhSMu0TQKPdq2MNVLH
	N3oNWW5rCAginMdVfwZ9c7u6HH02lh2Sm3BT6S+iENn4yFp/pCkQ9EjqkRAJm1A7MTeNGU21vlC
	6uVg2bACdaESWw3Z3PYLwvis5S/fDg80+NUqo8WzdTq7Fom180pp30D0h3jOiluil7c8jmVtLLg
	BW7N7cU5UaJesNa5BNCAQ4g/d3Q+R0xks3qxxMMPsOCOSGdeVbrYp5Qibd55l4DXM0KZwlHpPo2
	JRgBfOHcaWLQ7QTBOQdDIj+wAo1lYkjLxSYcZRrCwgmdkhphjrYKNSby0MQ+ImsOa0hRPa7vUM9
	8+oNTwGUPJvEJ1uBlziMMS8h6gtE/HePfC4oLMs3sO8u2pCvSiFOmwBYlqCKitGSqNUSEu/5+My
	0e7g1ZsFUKz5HqutzQeuzo=
X-Received: by 2002:a05:690c:4f10:b0:81e:fc6c:452c with SMTP id 00721157ae682-841a09b13f9mr14965927b3.9.1787028368949;
        Mon, 17 Aug 2026 21:46:08 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f3e5:832a:1675:b570])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84068075e00sm15870677b3.3.2026.08.17.21.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:46:07 -0700 (PDT)
Date: Tue, 18 Aug 2026 00:46:06 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Xiujianfeng <xiujianfeng@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiujianfeng <xiujianfeng@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
Message-ID: <aoPXqkqJJ5a1J9JZ@zenbox>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <6ab57477-69f8-4c60-852e-58ce7ef25023@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ab57477-69f8-4c60-852e-58ce7ef25023@huaweicloud.com>

On Tue, Aug 18, 2026 at 11:47:55AM +0800, Xiujianfeng wrote:
> +cc Nicolas
> 
> On 8/15/2026 7:20 PM, Justin Suess wrote:
> > Howdy,
> > 
> > BPF programs can attach to the locked_down LSM hook and contribute a
> > verdict, but they have never been able to ask the locked_down question
> > themselves: there is no way for a program to invoke the hook and learn
> > whether a given operation is locked down. (i.e be a caller of
> > security_locked_down rather than a consumer).
> > 
> > Today the state has to be fed in out of band, for example userspace
> > reading /sys/kernel/security/lockdown and writing the result into a
> > map. That is a time-of-check/time-of-use race: a security_locked_down
> > verdict can be raised at runtime, so the cached answer can be stale
> > by the time the program acts on it.
> 
> Adding the bpf_security_locked_down() kfunc does not actually solve the
> TOCTOU issue you mentioned. Even after bpf_security_locked_down() is
> called, userspace can still change the lockdown state via /sys/kernel/
> security/lockdown.
>
This would put it at the same raciness level as any kernel caller of
security_locked_down.

More importantly, the sysfs file is not equivalent to calling the
hook. /sys/kernel/security/lockdown reflects only the lockdown LSM's
static level.

security_locked_down() is a generic LSM hook and other
implementers of locked_down: including BPF LSM programs attached to
that hook (which is already supported) can contribute per-reason,
dynamic verdicts that never appear in sysfs. The composite answer is
only obtainable by invoking the hook, which is what this kfunc exposes.

> I fail to see the necessity for a BPF program to know whether a specific
> operation is locked down. The test case provided in patch 2 does not
> clearly demonstrate a scenario where this is required. In my view, the
> verdict should happen exactly where security_locked_down() is currently
> invoked.
>
Elaborating a bit more on the use cases:

1. Being able to know if features LOCKDOWN_BPF_READ / LOCKDOWN_KPROBES is
   locked down without a userspace hop / polling an LSM-specific interface
   for error handling.

2. Use with the BPF LSM implmentations of security_locked_down, without
   Lockdown even in the picture.

3. A BPF LSM can restrict access to arbritrary sensitive resources based
   on the security_locked_down verdict.

> Furthermore, based on the current implementation of Lockdown, integrity
> is the prerequisite for confidentiality. It is designed to be coarse-
> grained and does not support per-operation lockdown. The fact that LSM
> BPF can already hook into locked_down seems to violate this foundational
> model, this is is analogous to the bitmap implementation [1], I’m
> considering whether we should restrict BPF from attaching to the
> locked_down hook. Nicolas, what are your thoughts on this?

You describe a Lockdown-specific model, why should other security models /
implementations of the same hook be made to have the same semantics?

The point of the LSM hooks are to be generic.

(I have use cases that do rely on that hook; though I'm embarrased to
speak on it and it is probably abuse: I use this hook to temporarily
disable hibernation in BPF)

Justin
> 
> [1]
> https://lore.kernel.org/all/20250728111517.134116-1-nik.borisov@suse.com/
> 
> > 
> > Add a bpf_security_locked_down() kfunc that calls
> > security_locked_down() and returns its verdict, letting LSM and
> > syscall programs query locked_down state at decision time. Out-of-range
> > reasons are rejected with -EINVAL before dispatching the hook, and the
> > kfunc is refused to programs attached to the locked_down hook itself,
> > which would recurse into the dispatch. (how the obvious recursion issue
> > is addressed).
> > 
> > As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
> > to host it.
> > 
> > This kfunc has no reliance on / relation to the Lockdown LSM, despite the
> > similar naming. It is an LSM-agnostic caller of security_locked_down, and
> > Lockdown just happens to be the only in-tree subscriber to this hook at the
> > moment.
> > 
> > In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
> > all, and uses a BPF implementation of security_locked_down.
> > 
> > This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
> > enabled due to this line in security/lockdown/lockdown.c:
> > 
> >    pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> > 				                 current->comm, lockdown_reasons[what]);
> > 
> > Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
> > applies cleanly to the lsm tree.
> > 
> > Justin
> > 
> > Justin Suess (2):
> >    lsm: add bpf_security_locked_down() kfunc
> >    selftests/bpf: Test bpf_security_locked_down kfunc
> > 
> >   security/Makefile                             |  1 +
> >   security/lsm_kfuncs.c                         | 84 +++++++++++++++++++
> >   .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 28 +++++++
> >   .../testing/selftests/bpf/progs/lsm_kfuncs.c  | 34 ++++++++
> >   .../selftests/bpf/progs/lsm_kfuncs_fail.c     | 26 ++++++
> >   5 files changed, 173 insertions(+)
> >   create mode 100644 security/lsm_kfuncs.c
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c
> > 
> > 
> > base-commit: d82ebfc685c91e7f5623a8be949da1ddb767420b
> 
