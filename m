Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9C402435
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514718; cv=none; b=GMIAOfQ+zqk/gs9OdcjMZNpm/R3LWNcAKHJy14Xln7OzrYYHuKtudRbO7Za05eiGFekRYi3c0AauHmJK2YeVMIJDlND7+0vQSywPQ4fCEUc2Jdw2QaX3RKcuRBSq2O38qVS/LQxVs4rAd46q2JtLbzMCPEw1U3dsUQtR7/ceQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514718; c=relaxed/simple;
	bh=bPCZegAxHoeoycJru1ZuXUkag0ytA9Cy5ZI2BD2RvCY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uOKHBBn/cFK34Frt+hU1KWKs9u0BC2L07WWUQQldB2vglfJlFV549muCefHAHc/5S37YJnIXU2knuVQUuUvW1E5wwflvpPjN6pSK4V/+5ZV+wiBi/F/TJt6bGDUNyp/PdmsPnKW6EQO4CRj5dKfrnNCDuwl2qQ7OHbNI1coZtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHCDTHY8; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHCDTHY8"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dca4debedaso4456535a34.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778514715; x=1779119515; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8ymRLx5DRViBt7vQ33aUn3ouAwAfSpy9qoKhGae7+s=;
        b=dHCDTHY8J9G19VjDe2NN5XjTdUcnJp8qXE/U1ZDtkWTP7Uy1Ky9rs65ITpX4POGU/H
         eWL3CxsuLqYnklpaXDpf9qBPQ8arSI5IcrZ3fvxOQBsFl2XNkKGpL/Rlq7usFlRq7ATh
         Fm+R5EiWE0LV0VXhBz74PpDlAWRwmQOrcq0wOygBxm0Hbu8ggOQbvs9i+7o35v7jcBSe
         p5fFCm6DQlkj2OasbTH/XpCYWAkJ1YPvvRLZegWeEQ3Xr0ILKX8VGcHO0wLuAaoK1BK3
         jP5xoZ/78B7qtGJ/MtoE1ySO0N8GmI4SPg/fh/ANn58OJpQbbefK2vjGVGRWoe6xqCw9
         M8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514715; x=1779119515;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8ymRLx5DRViBt7vQ33aUn3ouAwAfSpy9qoKhGae7+s=;
        b=jk/azmE0d8DhsQgJ5i7VaoEB2hvSa76kd44tJZ2dnRKzTjBGwPpfSnZRBeYNMqXcaI
         nq7kT5H6BVUJx2NEF6KWL0MsjSBN6zVhVtsXZaRcS7WOyocAjcyHiYWCJ6rReIQvhoYh
         cxMaoTCrmTINsicKQAxmnGmoXdV4KXc/w5eb/jrLGt9ocgGRQ7B1nx4Yu65vpEsGjuvA
         eBIBIKKF9DlYGU+cOMp1Aw575v12ggw0m2MPXb/TnsuKt8uAspTO2nDVT2A+CWfTcxX/
         PGEZhLMl6bF1kPtMgBAlxV7W/azUMETYtYz7MWu1cRfHAff92gN24rdREIPM8FwmloNm
         CTMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dSJGrlVK48Niiqza9ZvOhEJSb0m8FGU3I0TJhEOhDnwmjJXZbWRqBhEqSxmvyx0HSomk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOXbAdh/s890+33encGE0y7RuhAbaoUC5CGvtAgbOxxEGBrsA
	k+rpFEDzaSE0/hyewBtLS+TxPQZGJoSYA3cHVWe/quXmjChieFVFrg+j
X-Gm-Gg: Acq92OE5nNN7wb9hFbhiIwfK1atIkBtylgVqoh/E6Eb2KOKhK45UZFVTbV4+L6Gitko
	BOsDDfTPEwZYaAxY03UnFiNgWQUfThJV08n3DPOuTyI+VcrgIxoxVpvDfFPusS1dDKkq39GEAgw
	zZ7BgugueLhzWSLvih65cdl6HEMZ6Gmr9SBbPyhq1hp797iB9qZ99ElyUtXEBflQK5bnfsvzBSZ
	IbytCam/XlIkIsb9Mc+S9240QFt4rU0qP1uJkB/6cMiyEUmWoPQy+Nk17PcDAVXF/GrTxkAvJzP
	zS4XvsN1an2+OMmZYUtvHvmJ8JwZn7rhEX+ZFSDbGOk963hiWxZt81zdG/Cne161PNXLSMlwwSM
	ugqPoC5gaTesj91TK1p/8pAEmn6J3P8H1fuSQ0DV3N19q6hBTDLSknBgr0cYDdjnK+XanFvztFO
	ER/xSAoD7jeeFByxWGCmxQLg93eohBxod6IyjvXNeJzRy14axFD+ihLCmIAmKu1dCVPbOy0d68A
	v4c45JQid9qr0ZwmA==
X-Received: by 2002:a05:6830:25d0:b0:7dc:5899:c711 with SMTP id 46e09a7af769-7e381f0fac8mr6693162a34.3.1778514715076;
        Mon, 11 May 2026 08:51:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d8fe3esm6861406a34.21.2026.05.11.08.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 08:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 08:51:53 -0700
Message-Id: <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
Cc: <sashiko@lists.linux.dev>, "bpf" <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from
 NMI
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>
X-Mailer: aerc
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org> <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox>
In-Reply-To: <agEnc0aYMhuIeDlq@zenbox>

On Sun May 10, 2026 at 6:49 PM PDT, Justin Suess wrote:
> On Sun, May 10, 2026 at 03:38:08PM -0700, Alexei Starovoitov wrote:
>> On Sun, May 10, 2026 at 8:14=E2=80=AFAM Justin Suess <utilityemal77@gmai=
l.com> wrote:
>> >
>> >
>> > Any help or guidance on this would be appreciated!
>>=20
>> sorry for the delay. Everyone was at lsfmmbpf for a week+.
>>=20
>
> No worries! I hope it was an enjoyable trip and I look forward to
> hearing about the conference.
>
>> All of the solutions so far are way too complicated.
>> bpf_kptr_xchg() has to remain inlined as single atomic xchg
>> without slowpath otherwise it ruins the concept
>> and makes usage unpredictable.
>>=20
>> Let's step back.
>> What is the issue you're trying to solve?
>>=20
>> the commit log say:
>>=20
>> > A BPF program attached to tp_btf/nmi_handler can delete map entries or
>> > swap out referenced kptrs from NMI context. Today that runs the kptr
>> > destructor inline. Destructors such as bpf_cpumask_release() can take
>> > RCU-related locks, so running them from NMI can deadlock the system.
>>=20
>> and looking at selftest from patch 2 you do:
>>=20
>> old =3D bpf_kptr_xchg(&value->mask, old);
>> if (old)
>>   bpf_cpumask_release(old);
>>=20
>> so?
>> bpf_cpumask_release() is fine to call from any context,
>> because bpf_mem_cache_free_rcu() is safe everywhere including NMI.
>>
>
> My mistake on that. I picked a bad example for the test, but the test is
> just exercising the nmi dtor path, and doesn't rely on the particular
> type of kptr. I just picked one that was easy to acquire a reference to.
>
> This dtor is safe. task_struct dtor, cgroup dtor, crypto_ctx dtor are
> not. I've annotated why here:
>
> crypto_ctx:
>
>   __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
>   {
>   	if (refcount_dec_and_test(&ctx->usage))
>   		call_rcu(&ctx->rcu, crypto_free_cb); /* UNSAFE: call_rcu */
>   }
>  =20
>   __bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
>   {
>   	bpf_crypto_ctx_release(ctx);
>   }

bpf_crypto_ctx_release() is only allowed in syscall prog types
and dtor via hashmap free will execute in safe context as well.
So not an issue.

> task_struct:
>
>   __bpf_kfunc void bpf_task_release(struct task_struct *p)
>   {
>   	put_task_struct_rcu_user(p);
>   }
>  =20
>   __bpf_kfunc void bpf_task_release_dtor(void *p)
>   {
>   	put_task_struct_rcu_user(p);
>   }
>
>   void put_task_struct_rcu_user(struct task_struct *task)
>   {
>   	if (refcount_dec_and_test(&task->rcu_users))
>   		call_rcu(&task->rcu, delayed_put_task_struct); /* UNSAFE: call_rcu
>       */
>   }

In theory. I don't think there is a reproducer.

> cgroup_release_dtor is more complex, goes through ultimately through
> callbacks to:
>
>   static void css_release(struct percpu_ref *ref)
>   {
>   	struct cgroup_subsys_state *css =3D
>   		container_of(ref, struct cgroup_subsys_state, refcnt);
>  =20
>   	INIT_WORK(&css->destroy_work, css_release_work_fn);
>   	queue_work(cgroup_release_wq, &css->destroy_work); /* UNSAFE:
>     workqueue */
>   }

similar to task_struct. I don't think it's exploitable.

> More generally, unless it's a BPF allocated object or doesn't rely on
> locking/call_rcu or workqueues, the dtor is unsafe.
>
>> hashtab introduced dtor in bpf_mem_alloc,
>> so bpf_obj_free_fields() and corresponding dtor's of kptr-s
>> are called from valid context.
>>=20
>> What is the problematic sequence?
>
> So from the beginning stepping back.
>
> The problematic sequence:
>
> 1. ref kptr (i.e task_struct, cgroup, crypto_ctx) xchg'd into map.=20
>
> 2. in a tp_btf/nmi_handler (NMI CTX) program we drop the item from the ma=
p
>    with that referenced kptr field.
>
> 3. dtor runs in the nmi context
>
> 4. dtor runs call_rcu/queue_work/some bad thing in nmi, causing deadlock.
>
> You can see this demonstrated in my task_struct reproducer [1].

did you?
That link points to your v2 with cpumask.
I don't recall seeing task_struct repro.

> It causes a deadlock by deliberately releasing the last reference to a
> task_struct via a ref kptr in nmi, getting it to call_rcu and deadlock.
>
> The typical solution to this is to run the nmi unsafe code in non-nmi
> context by offloading to NMI work, as you proposed.
>
> The problem is we need space to for the jobs we enqueue. The required
> information to run the dtor is the dtor function and the original object
> pointer. The number of dtors that can run in a single tp_btf/nmi_handler
> prog is nearly unbounded.
>
> The other problem is even though bpf_mem_alloc is safe in NMI generally,
> we cannot allocate in path that destroys an object. If the allocation
> fails due to memory pressure, we leak the object.
>
> There are a few options, all with drawbacks.
>
> 1. Dynamically allocate the job. Non-starter, failing to allocate is
> unrecoverable, memory pressure means we can't ever schedule the dtor to
> run.
>
> 2. Store job ntrusively in the object : Requires a safe place to place
> it within the object. Bad because not all objects have a space we can wri=
te to.
> Non-starter.
>
> 3. Within the map slot (after actual kptr): Taken with my initial approac=
h in v1.
> Significant complexity and requires per-map changes. Feasible but very
> complex and would need DCAS or locking to make updating the map slot and
> our job information atomic.
>
> 4. Wrapping the kptr in a box and storing it in place of the kptr [2] :
> Proposed by Mykyta. Would break direct load access to kptr objects.
>
> 5. Make every dtor nmi safe individually. This would require a lot of
> duplicated code and require updating every destructor invididually.
> Feasible technically, but seems brittle.
>
> 6. One that would be the least complex, would be forbidding xchg operatio=
ns
> that can run the dtor in NMI context. That would preserve the inlining fi=
x,
> but limit our usage of referenced kptrs in BPF programs that run in NMI c=
ontext.
>
> The approach here:
>
> 7. Allocate a new spot for a free job every time we xchg into the map
> and put it in a global list. When in NMI and we run a dtor, we pop a
> job from that slot and use it to offload our work via irq_work. If
> we're not in NMI we run normally. Downside is this breaks inlining for
> ref kptrs.
>
> ...
>
> I may be missing something critical, but everything I've looked at
> points to this problem being much more complex that it initially seemed.

yes. it is complex. all 7 options are not good.

I recall the whole thing started with desire to add bpf_put_file_dtor().
This was discussed with VFS maintainers and they didn't like the idea,
since it needs a ton of work to make it safe:
. umount notifier to make sure stashed file doesn't hold umount
. potential circular refcnt issue if file to bpf map stashed into the same =
map
. scm_rights-like facility with garbage collection

So generic file stash is really no go.
