Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B535CB87
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712956; cv=none; b=J2jZoZ8oTnGP8p2cd072CY+F2PUgLKbR0WUN+cZQxsS/nkM4d0BfDykT2f0SOcjDHGs/SkS+4pbOf93/zGc9ha/4tbMH/TURETd4yZoft/iw7JpbM1xzo48P502tOFSCaszbKYu4PUx2KBqxEalIwx6Guuh7VgjyZloBtubv4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712956; c=relaxed/simple;
	bh=yYBkCJueX6Kc2AmnzeucM2qqGpcSOnx/no1rkxLanPE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KU6pbvr+L3QDn9jkjca7kxBN4icU4LuMIYo4d5oeHBttMwjm5BxlrGBgC89V87CqJj23ssMvnSY5sL8NLRzfsVroi2A9CumfUXnHLSsT/QXkrxSivpmYCCIqs/NneKGWyYOLYV3/Cgb/OSuGAxDx4u0BFL9LFiytO06ZaZZIMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll6RJMj4; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll6RJMj4"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so1415468f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785712952; x=1786317752; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j4pa8BZIB2gNIeGlkaWBqhpoJbI1D4n977OZhkSLC7U=;
        b=Ll6RJMj49qo1f5vp3uAmvVbLE40l37PwVGDONfEpneUi5YZUU3hvrVdw2Po3SUYQSs
         z1/5u5LzEy29rGXavolo5Gcq6BBnb2FpY32UKrxvl9OYnV/Jm3QigHrjbZo1LKAjYN4k
         daD1rG56W7a+/zzSVpDiFcnZx3A8DVBl2V2/Asmml6no/4KUislLN3zjBxIwTuhA4x46
         I1jLGzVY6t8qQ1sQZ0QEE+j9iMSjf+3Nd+KNSuG69/238YWuEn9YZpEzPMGpVauzlizA
         +AhmRNu9C6erB+rtrsNDp6v7fvSRAI+YFOOzqgfiKjLQ1HqGWogWZSYC3BU0i2oFYK6c
         I7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785712952; x=1786317752;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4pa8BZIB2gNIeGlkaWBqhpoJbI1D4n977OZhkSLC7U=;
        b=cv4c+jDdqONE0lQ1o0CDGn0K9JrT/zYkcHlJ9QoMvUYW+ZkmgN2Yw4f5vOwNYXn1ne
         VyXrgHOs0AL9ZTBecY6xAnnv0OsE4iEtTL1kOAeGJo0/bx6pzwOs3G+ZGZiYsQGhHpmE
         lxwomQ3jB3+aOp+L9/+l/ZPjxFjWWmx3ysNAHAxshxT0mjgltoHSl4NZh1WgwcvDkKzs
         ISgwkUvmSI07e6sSn/kKiPFzaCV+jSyNpqbkhTwXGdJZ2BDkS6Wz3ME2ZulEkDAus0W0
         tbOoXS9Lz6Z2LYZzh9i9chA0/tKQrP1iA4y72GNYfb6Hsdfr/n+HI/aAcuRbXTVAbaMJ
         y6Gg==
X-Forwarded-Encrypted: i=1; AHgh+RoU8tBPOgUympI18HV+ORrarFL/e9zmOL0ZtyaAb7BuT7fdD+YMfdYTstxBh7NCEZQ1krg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZwhPJ3Wpx28h8H3fS1P5E8ttyEYAWlD0CRsVUPKOQi0EcDD9
	oJamA8RNwe+VnoIt/58DetpSCxUAgIf7IBYCyBcDErETLpt15wzFIUpK
X-Gm-Gg: AR+sD12ANsjTdvkA1KzlocDxPxty4ZAmApgtP7Rb1aXgGm1/gOIY+IgiEAWH7/fzGJH
	Psidurhkd81IYJQDxvv0+Yx5iCVqDRAaMO73njbd4UGgSJ2S6T5Zep1uj8L4qpaEd4znHymbxBC
	PMS/44WdO0m1qulPrjEDE2HyXAJKgkxUmm5056hsU21V0rVemBbn9hDR6hbvPbhgPH+owz3g6lu
	72581xAbLlvsLZSJIegoNAwVUUi8udTZSvGpy/+DSh4c6KsmF03hsVqkBa7CrDvpeczc9asKaLl
	G/CKhe3NL+QpcfV7DjXOlmR+/P3XmUn30Yjz5IHEQvBFtziyeAdlbgaJxJZV8gkP8jSQNBprxqX
	YJaaGK+FOfTL8J8iHei6tJt+1v0SDPWTGwrG9JaPk8nS5INk1o1GacMAj6n/Y41t5AVAR+ZEQ1Z
	Xlt3Nbo/nqtV944K4SXSZ3Oc2jPxclOBrXQWVaOunSTj7D54oOy1gvPCgdfiSu5YfYghkJa/fZT
	ay1ViuUvxzLyFlm1OsCvt0eHxKSLqyu7QgM+uGbmQbyoNwa8tIh8eXG5NQjBxYUNT+9hdIiQ8Ek
	hs4GwOH0il2VgwfcKt1l1EOfKY8=
X-Received: by 2002:a05:6000:1787:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-47fd7262860mr20618429f8f.0.1785712952118;
        Sun, 02 Aug 2026 16:22:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562a38sm26713398f8f.21.2026.08.02.16.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 01:22:31 +0200
Message-Id: <DKEUESWLOHMH.4KP4IBSQ9ZV6@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Justin Suess" <utilityemal77@gmail.com>, "Amery Hung"
 <ameryhung@gmail.com>, "Dave Marchevsky" <davemarchevsky@fb.com>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Invalidate RCU pointers after final spin
 unlock
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260802231248.2781334-1-dingning04@gmail.com>
In-Reply-To: <20260802231248.2781334-1-dingning04@gmail.com>

On Mon Aug 3, 2026 at 1:12 AM CEST, Ning Ding wrote:
> A verifier-tracked spin lock provides implicit RCU protection while held.
> Consequently, a kptr loaded from a lock-protected map value is marked
> MEM_RCU.
>
> process_spin_lock() invalidates non-owning references on unlock, but leav=
es
> RCU-protected references intact. This is correct while another RCU contex=
t
> remains active. However, for a sleepable program, releasing its final loc=
k
> can end the only RCU-protected context. The verifier then allows a MEM_RC=
U
> pointer to be used after its protection has ended.
>
> Invalidate RCU-protected references when a successful unlock changes
> in_rcu_cs() from true to false. Non-sleepable programs remain in their
> invocation-wide implicit RCU context, and an explicit RCU read-side secti=
on
> continues to protect pointers across the unlock.
>
> A task kptr retained across the final unlock can race with removal of the
> map kptr and bpf_task_release(). This was confirmed to result in a
> task_struct use-after-free in __bpf_get_task_stack().
>
> Add a negative sleepable regression and positive non-sleepable and explic=
it
> RCU controls.
>
> Fixes: 5861d1e8dbc4 ("bpf: Allow bpf_spin_{lock,unlock} in sleepable prog=
s")
> Assisted-by: Codex:gpt-5.6-sol
> Assisted-by: ChatGPT:GPT-5.6-Pro
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---

It makes sense, but split the kernel side fix and selftests into two separa=
te
patches. The list has several examples. Also, I don't think this is as seri=
ous,
so please target bpf-next in the respin.

pw-bot: cr

>  kernel/bpf/verifier.c                         |  5 ++
>  .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
>  .../selftests/bpf/progs/task_kfunc_common.h   | 12 +++++
>  .../selftests/bpf/progs/task_kfunc_failure.c  | 24 ++++++++++
>  .../selftests/bpf/progs/task_kfunc_success.c  | 48 +++++++++++++++++++
>  5 files changed, 91 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fdc5fbb1f78c..aea9fdbbd33a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -204,6 +204,7 @@ static int acquire_reference(struct bpf_verifier_env =
*env, int insn_idx, int par
>  static int release_reference_nomark(struct bpf_verifier_state *state, in=
t id);
>  static int release_reference(struct bpf_verifier_env *env, int id);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> +static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
>  static bool is_tracing_prog_type(enum bpf_prog_type type);
>  static int ref_set_non_owning(struct bpf_verifier_env *env,
> @@ -7051,6 +7052,7 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, struct bpf_reg_state
>  			return err;
>  		}
>  	} else {
> +		bool was_in_rcu_cs;
>  		void *ptr;
>  		int type;
>
> @@ -7078,10 +7080,13 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, struct bpf_reg_state
>  			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
>  			return -EINVAL;
>  		}
> +		was_in_rcu_cs =3D in_rcu_cs(env);
>  		if (release_lock_state(cur, type, reg->id, ptr)) {
>  			verbose(env, "%s_unlock of different lock\n", lock_str);
>  			return -EINVAL;
>  		}
> +		if (was_in_rcu_cs && !in_rcu_cs(env))
> +			invalidate_rcu_protected_refs(env);
>
>  		invalidate_non_owning_refs(env);
>  	}
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/=
testing/selftests/bpf/prog_tests/task_kfunc.c
> index e6e95c1416e6..fbd7855712c1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> @@ -176,6 +176,8 @@ static const char * const success_tests[] =3D {
>  	"test_task_from_pid_current",
>  	"test_task_from_pid_invalid",
>  	"task_kfunc_acquire_trusted_walked",
> +	"task_kfunc_acquire_after_spin_unlock_non_sleepable",
> +	"task_kfunc_acquire_after_spin_unlock_explicit_rcu",
>  	"test_task_kfunc_flavor_relo",
>  	"test_task_kfunc_flavor_relo_not_found",
>  };
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tool=
s/testing/selftests/bpf/progs/task_kfunc_common.h
> index e9c4fea7a4bb..052c9d0e3e2a 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
> @@ -20,6 +20,18 @@ struct {
>  	__uint(max_entries, 1);
>  } __tasks_kfunc_map SEC(".maps");
>
> +struct task_kptr_lock_value {
> +	struct bpf_spin_lock lock;
> +	struct task_struct __kptr * task;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct task_kptr_lock_value);
> +	__uint(max_entries, 1);
> +} task_kptr_lock_map SEC(".maps");
> +
>  struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
>  void bpf_task_release(struct task_struct *p) __ksym;
>  struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
> index 8942b5478129..7a0c7ee95511 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> @@ -378,3 +378,27 @@ int BPF_PROG(task_kfunc_release_in_map, struct task_=
struct *task, u64 clone_flag
>
>  	return 0;
>  }
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +__failure __msg("R1 must be a rcu pointer")
> +int BPF_PROG(task_kfunc_acquire_after_final_spin_unlock)
> +{
> +	struct task_kptr_lock_value *v;
> +	struct task_struct *task, *acquired;
> +	int key =3D 0;
> +
> +	v =3D bpf_map_lookup_elem(&task_kptr_lock_map, &key);
> +	if (!v)
> +		return 0;
> +
> +	bpf_spin_lock(&v->lock);
> +	task =3D v->task;
> +	bpf_spin_unlock(&v->lock);
> +	if (!task)
> +		return 0;
> +
> +	acquired =3D bpf_task_acquire(task);
> +	if (acquired)
> +		bpf_task_release(acquired);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_success.c
> index d63a79ee33dc..2bab7634c9df 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> @@ -6,6 +6,7 @@
>  #include <bpf/bpf_helpers.h>
>
>  #include "../bpf_experimental.h"
> +#include "bpf_misc.h"
>  #include "task_kfunc_common.h"
>
>  char _license[] SEC("license") =3D "GPL";
> @@ -366,6 +367,53 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, stru=
ct task_struct *task, u64 cl
>  	return 0;
>  }
>
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int BPF_PROG(task_kfunc_acquire_after_spin_unlock_non_sleepable)
> +{
> +	struct task_kptr_lock_value *v;
> +	struct task_struct *task, *acquired;
> +	int key =3D 0;
> +
> +	v =3D bpf_map_lookup_elem(&task_kptr_lock_map, &key);
> +	if (!v)
> +		return 0;
> +
> +	bpf_spin_lock(&v->lock);
> +	task =3D v->task;
> +	bpf_spin_unlock(&v->lock);
> +	if (!task)
> +		return 0;
> +
> +	acquired =3D bpf_task_acquire(task);
> +	if (acquired)
> +		bpf_task_release(acquired);
> +	return 0;
> +}
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
> +int BPF_PROG(task_kfunc_acquire_after_spin_unlock_explicit_rcu)
> +{
> +	struct task_kptr_lock_value *v;
> +	struct task_struct *task, *acquired;
> +	int key =3D 0;
> +
> +	v =3D bpf_map_lookup_elem(&task_kptr_lock_map, &key);
> +	if (!v)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	bpf_spin_lock(&v->lock);
> +	task =3D v->task;
> +	bpf_spin_unlock(&v->lock);
> +	if (task) {
> +		acquired =3D bpf_task_acquire(task);
> +		if (acquired)
> +			bpf_task_release(acquired);
> +	}
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> +
>  SEC("syscall")
>  int test_task_from_vpid_current(const void *ctx)
>  {

