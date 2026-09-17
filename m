Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398F3812ED
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611867; cv=none; b=dvuwn1e87WkvnT51ZaFXqYkUAbKVMFzk7ecH28RF5oXEFkIqAByXSJcJ6ktNt1VnXgdl2e7+GBXsQQklA1rsqi79mG68YzIjsZ62xSYK+zd4KN6f/5nQzalY9oWUHt35cOOOSJLyw1wcmxHqMhkJGox/mv6fx0yYf2fT4fWJnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611867; c=relaxed/simple;
	bh=E+msnkVkMuv7EW3/XyJSZb0DiTqaEOW4e8lxU2bUdDk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=WHtlHNkGHPbNUhMXtVI0BBEnKP8ObdBpjXBXeiYhwATyu0orihaKiUyqtCFSAVJrsxFEkESwawtAWWiLfIlEbZbNoZAK4hSskQEQkzyDcXZ81REZwe1dp9Ge7W+cYfFTrTLtpRPeAsIqTFKtKxsh3iWnuqx6jIhJN83UavYgrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfozeCmU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfozeCmU"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so3501345ad.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789611865; x=1790216665; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6EKmqByiGxzJPh+0Mll6vjXYdVK/vy8pIRVPNPfe0KQ=;
        b=DfozeCmU42c3ZQt6zeu2eLYJawKiY6mKFmktJGlatz7kS0KtK38o/GFcK0d5SnwSzg
         Mjdec2QO6eboPe2Jz4IkKLjF/iIv0aBkjdGl8vvrUkCEtctay+UHUKqR9DVS+y+KVpob
         tncm79dXTOTPcDu9g9fjUDBbfMrrWN2AQ9kgDGSwv2d3BckJdz4kWNueJQrwT2QE+PI7
         EH8vqv5Tjnq6dBxaNOQhZeBpEqZcgXhQglEoY7nbKJDPfzEdiS0Zrafzhhq6OdQYBxWH
         dbUC21FZJB4V4N6W5UsLx6JZ1N41Q/dd4w4rYK3UVq+xlao0i/8nLQZPfdyxgebsGQDe
         YxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789611865; x=1790216665;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EKmqByiGxzJPh+0Mll6vjXYdVK/vy8pIRVPNPfe0KQ=;
        b=A9rUqCyjaje4HzMFvfuDPy+gNyC0H039c/OYY9zqPmhbeLceLRxCr1vYInAM3HU0v2
         oXM6Z7RblWsKfkgbuI1bbTWh6Gwp07BpTXyZ8pR/m7uWd629BmdFYZVdZ4xI+Rx0Kp4l
         n9iK7objFxpub1n518AkX8CW9DSI4CwrAuMZZmXbBGwErMC6Edf/PTS5yLm0RavIaCuZ
         FrL0vzMDrfB9ro7yfwkciEPjOYJFexSE7MVW32/EA2HTyPLRWzuM9rDrzb75tmkpEaCS
         dC4Us7RiwpnxKCkjYOXYzUBNaahliEoZIuXQhFbkx94osJK9CfWU3TtckasaTrZGcIJS
         e7KQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5CFiQ/+CwbzYuyihg1U43M04ucEq+QyjT5CxUIBgtPudrjN0yBJ8rIeoy18G1E+tOk0M=@vger.kernel.org
X-Gm-Message-State: AFuF++mkYi1MDkKe1MN19DarZz4RrOBBKzIreRTG0NhUahnl83/s4nM4
	LVFt+CZmXo4dtfybLcMHPQmdzZie9bDmW3HALR6ZoSfksQRa0R1rkIOx
X-Gm-Gg: AYBFou3oN+Gl5a+XECme0ylrD8POMfPq1tFA9gY2nlCZCvKaIbhwLwMGSCp9+Bq7L2o
	fFs403g3rSrqJYF2/ebm46KmBE+yC4x8GlYsxzHjn9QU4QVfk2ACUA3cLzHKoZoc2cG9iLRfRyw
	8ofQoiNIfV/ChuhgmKtJkP0/Wm1jwLfKC2qw7bgurow7l42bl8sIWErqd7CZGuIMoZv8X22dFBh
	YC04dE7ReQ4CGzTG4hFz2I6koKk+cYI5kDOIpomASbWE9kkGB+5tLkgSTiU8Ct1OkDovyMdy2r+
	X01kdjq5nT+MefoWL3enxOUA3Kihe6ixOaRqieJt5ZsD+FaE89wMgNwIF7+Fknt1Aqfl1nqmnV7
	4peVKnZjlCzVhl6DArTTfnavXtx2yDMXNSsdwhAqW2bzgqKY3jCs2uvYba8ebO2W5lpN9A0Sk+t
	sCOsKfkOdSaLXcq8L634TYEkRDGct08qeCywvuRsTJhb+UPaTfWJHybFjWN7c4Z64eBKMVVzLpN
	lqBHn2V10R/AGwuj/brajXWNWYpyNJO68jCyaVi6HzxVOLnRPgQYmv6Qsv7FLCS4Q8sCioUleIA
	Lp6m
X-Received: by 2002:a17:903:1ac7:b0:2dd:60d:8b7c with SMTP id d9443c01a7336-2dd8e3f57f8mr114351815ad.13.1789611865419;
        Wed, 16 Sep 2026 19:24:25 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89ee3557sm18694235ad.52.2026.09.16.19.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 19:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 02:24:24 +0000
Message-Id: <DLH8GKM4B06Y.3HTSEM5YGFR5D@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, <x86@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross" <jgross@suse.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC v3 06/13] bpf: Take a Tasks Trace reader in the
 trampoline glue
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com> <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com> <a51c15af0d61414aa780e7646b8e74cd.josef@toxicpanda.com>
In-Reply-To: <a51c15af0d61414aa780e7646b8e74cd.josef@toxicpanda.com>

On Thu Sep 17, 2026 at 1:16 AM UTC, Josef Bacik wrote:
> On Wed, 16 Sep 2026 03:45:16 +0000, Alexei Starovoitov wrote:
> > On Tue Sep 15, 2026 at 1:17 PM UTC, Josef Bacik wrote:
> > >  	__acquires(RCU)
> > >  {
> > > +	bpf_tramp_read_lock_trace();
> > >  	rcu_read_lock_dont_migrate();
> >
> > This is double increment. rcu_read_lock_dont_migrate() includes
> > rcu_read_lock_trace().
>
> Unless I'm looking at the wrong tree it doesn't, on Linus' master and on
> bpf-next it is
>
> 	static __always_inline void rcu_read_lock_dont_migrate(void)
> 	{
> 		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> 			migrate_disable();
> 		rcu_read_lock();
> 	}
>
> so plain RCU plus migrate_disable(), no Tasks Trace reader. That is why
> the non-sleepable glue needs one added here: on these architectures the
> trampoline image the glue returns into is only kept alive by Tasks RCU
> while the task is a rcu_read_lock_trace() reader, and rcu_read_lock()
> does not give us that.

Right. I got confused. Since rcu_read_lock_trace() CS will cover
both sleepable and non-sleepable prog types let's do it once
per fentry+fmod_ret region and 2nd time for fexit region.

We probably don't want to hold it for the whole trampoline,
since orig_call will delay freeing of progs.
