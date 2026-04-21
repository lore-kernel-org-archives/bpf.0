Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA472E03E4
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807922; cv=pass; b=s/zMFxClM9iI2bGqSdvnafuyLdLTRSZr2ocin++4uqib6nUFg0b8AHd8QIO6E/YRuOjiq8JUsZr1X6xbFsxybYM3r+AgJbgLM3TO5bzsy6PnlbnuVtnE+T0vSJl7o6NEKVzy0UREJhvbv8YZ48MsxplYrySNziuqiczjdgEh4XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807922; c=relaxed/simple;
	bh=aLBQqogXiQnDAgrWjL3MyT2X7ayOR9M6yPX7YVeonrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOfojga++qNv5EJHBqnW8jlCRhbP4pBoKYO0GUBv+XZjqhMmwUmbVQFpxAqPbbU24vnQoKCL6HsJRAUft0QhC0Fex7QDnDbERtFKb5EPRqGcNJ9AwPQng10QUz51I4ymGAfiub9bteo/nSaWY3ldG4Y0WppyWoNu7iSyQ5aOMPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXuJE4uE; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXuJE4uE"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d572f7437so3167294f8f.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776807919; cv=none;
        d=google.com; s=arc-20240605;
        b=exAIcPWzRf0qIqEHPnqA9S9amVlkuVctwuS1R5Bx4JZ1uOOWvkFJzLplZsJWC4gziK
         wCtJkW32nrJKj1uEC0keQdEaDXnlURuxemBdwuIXA/gyZON9lF4Y96qhH8Mb53u4StKo
         fu1CBGy94LLrGDY551EIPlptw+EFziWAjIdvj2xxly7tpmEtwoEkEqpqKC6hpc896EHr
         FWln3GRa28pl2RFY5QMuIlnVhB1TVSPP5punqaVdl9nZYBt1ZFbXTdqj2SytqKZJuf92
         I6bJjcv4Gj8U5Bjr+mjLPRqQ66sV+W0DiP/IbPgdLG9Zzgg5GV4sPjmDHBBYSRcbXyYO
         TXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1tEHjUMesxf7JTxb386tgQifr3AELd5fg5na4lWJ9R4=;
        fh=1uNWLdpXngJp60bqJOtI34s5d+/7bGwl2M2iDGSoq3Q=;
        b=UJt54Lrsnp1N+M/QRojgg5PDUK1LtWuvi0P2gAey/0OsMRSPnSkXDIS38WIBcrIYCp
         BZa1U+ck2VVB/tCDkqLPo0Q2A1zwAAMEozCH8/8vXsx1Tct2vd6GlZXnahEHMupgOwOT
         zCasdfCA0JU31NCQYvkfnZ4JmHhaAK5NxNvat8BS4w6u/oE2pcf1bYPKlpw5eCE3ZNA/
         yI9LmPnLa9mDc3g0BVDYokW2bJg5SIqgBJgv6laKY71zZz3w1wEdJYZArkVo5y1d8NWk
         mXPmLYSQ60Ed5d1+O+VnpQDcU5MJYxbU2Hjba/TXWIln2B2ifhzG744a5K90Arg+Sagv
         T0uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776807919; x=1777412719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tEHjUMesxf7JTxb386tgQifr3AELd5fg5na4lWJ9R4=;
        b=kXuJE4uEX0HU/IIcdsTPKPDJ+gEi7F/Oo9HojB7qIVHHdmRIuZHKQztEtLAD/pAkwl
         dvIQ/6dyKSiwdUi8EkTrwOHzW9gZX3WK3qjSKUHD6V5QQTqSr7RXfWi4QjhCmWyu8nuz
         wJh/1lcRLfw/EmNT8vtvkKuIfd08lvdpfq5KU2kbyrJDQhJWAPslbH9FkUB08CH4kXzR
         EOQGK55NDBN9SPC9afOVRNbqdfD+Ljc1dsyFNNYa0o9lr/h6/wzlVunkCJ1qvapxWNpp
         Vx5Q4bnrlsejGdmBUwGwrQXSaQJA2iEm12SoDJviX924lrefb2gsM76RWMREZmNiTBeh
         mIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807919; x=1777412719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tEHjUMesxf7JTxb386tgQifr3AELd5fg5na4lWJ9R4=;
        b=rfRJ+B9fc2eVCaEWrHpPOzgX2hNhPsBVmsCQseQMKF5t3wq6TPqY19GHt6QDS2BiIF
         F3nePO3OOKrSR8oGqWSJHUZj5kVhaHGELWr5QL9lcHs7QWqBAiCiXDpf+J9M7lkPm9di
         Cv/kHLE+2a95cqaV+Tk3jnOKbe4szivvI18e0r+CVuaV/tw+my2/VuU4YiHtuDL06NWY
         vq55O+oS5UAD8WKRc4dm1rT/LMC6exRA1mQiuQF30Zygc1XjTiS0iKQtX5fMFk+M7zRt
         tXuKuQ0VG6v5zew7SegqyOyh+uRkdfWWHQurQjWRDTmrJwrca/RGiz3QUg53/+b7H/q7
         yaDg==
X-Gm-Message-State: AOJu0Yx2mF11I46zahs+fyCYOAJg0Fajxjwb6HSwmwMcmwGn+hDpX08I
	yHxeWkqAUTMVYW1Gonb2orn7nnv8XLKvlFjeCeKakQ8Aq9VClpk9E6Bm7kO0ps4/Bm7mIs433kl
	6m+29MZy8mtng8Eb73NqmHbYoq9mm3GA=
X-Gm-Gg: AeBDiet9txSSY5RsiQpaH/29oNHIaUaRnrkJ1cYG2p3CkMEfPqiyB8Rk85nvASF59h+
	c4W3uLeN3O8OAHtwZnWgtfwqFENyf1BAcoFLNDOq8eu7qnYpHQmVe4AckMX5I7E2nR+6QExpcXm
	8LSQtNSSc/y6iWAHg2R4+UAoc0nuc+Irdq4DLd9gHygVnifUH1vk2f3QzHahyjL6HShtlogU0Lo
	nH/p77Nr3CoFFi+BumCdgcoPF4ZqfxrGlSuI/6bU7mOydYBLBWM+K1lW1nwqDbiPenSyJ+NHZ3z
	UeWPHi6daQ/44ZXA7i/2TijoLjQ9/FtqfF/dWJJsIEj0DWRljBPoqpCF6gh74cV77UiYlBzGaNa
	X757doYQATOyCDPxQ8CUEz3ekXCqNhgpnO8O1wloOnTXOaai/8t6DzSFZabV4qEq+uOQ=
X-Received: by 2002:a05:6000:2dc6:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-43fe3ddcc21mr30540368f8f.21.1776807919123; Tue, 21 Apr 2026
 14:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421201035.1729473-1-utilityemal77@gmail.com>
 <CAP01T77FND4_i0fB8zrYPJj0HAx=CkvTFB4=eV4EyZbdpuqgow@mail.gmail.com> <aeftTnQjdOgjZyYP@zenbox>
In-Reply-To: <aeftTnQjdOgjZyYP@zenbox>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 21 Apr 2026 23:44:42 +0200
X-Gm-Features: AQROBzApraBfJKtY1-jpRMjgF3zYsCaQO1YmOvg62_FlxUFCz2aMfx2Q3-sYaDc
Message-ID: <CAP01T77626uOQLrxkiMRDE_-VyMO=BDEYYRNEW1fgkj9yRv1NQ@mail.gmail.com>
Subject: Re: [BUG] bpf: Soft lockup / panic triggered by bpf_task_release_dtor
 from NMI on rcu_nocbs CPU
To: Justin Suess <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 23:34, Justin Suess <utilityemal77@gmail.com> wrote:
>
> On Tue, Apr 21, 2026 at 10:23:56PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 21 Apr 2026 at 22:10, Justin Suess <utilityemal77@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > I found a reproducible soft lockup / panic involving BPF task kptr destruction from NMI context.
> > >
> > > It was found after further investigation from a Sashiko report on my patch:
> > > https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/T/#t
> > >
> > > The issue is reproducible with a BPF selftest-derived reproducer that:
> > >
> > > 1. Stores exited task references in a BPF hash map as refcounted task kptrs.
> > > 2. Deletes those kptrs from a `tp_btf/nmi_handler` program.
> > > 3. Runs on an `rcu_nocbs` CPU.
> > >
> > > In my setup this eventually triggers a soft lockup and panic in a workqueue thread stuck in:
> > >
> > > `perf_sched_delayed`
> > > `  -> static_key_disable()`
> > > `  -> arch_jump_label_transform_apply()`
> > > `  -> smp_text_poke_batch_finish()`
> > > `  -> on_each_cpu_cond_mask()`
> > > `  -> smp_call_function_many_cond()`
> > >
> > > The triggering condition appears to be that `bpf_task_release_dtor()` can run in NMI context and reach the last-ref `put_task_struct_rcu_user()` path on an offloaded RCU callback CPU.
> > >
> > > Affected code path is a dtor triggered by deleting the last reference to a task_struct kptr:
> > >
> > > `bpf_map_delete_elem()`
> > > `  -> htab_map_delete_elem()`
> > > `  -> free_htab_elem()`
> > > `  -> bpf_obj_free_fields()`
> > > `  -> bpf_task_release_dtor()`
> > > `  -> put_task_struct_rcu_user()`
> > > `  -> call_rcu()`
> > >
> > > This is triggered from:
> > >
> > > `tp_btf/nmi_handler`
> > > `  -> clear_task_kptrs_from_nmi` (reproducer bpf prog)
> > >
> > > Environment
> > >
> > > - x86_64 QEMU VM
> > > - PREEMPT(full)
> > > - `CONFIG_RCU_EXPERT=y`
> > > - `CONFIG_RCU_NOCB_CPU=y`
> > > - booted with `rcu_nocbs=1-7`
> > >
> > > [...]
> >
> > Makes sense. I think the reasonable path is to just close usage in the
> > NMI context, otherwise we must address each case. Could you try the
> > attached diff and let me know if it successfully rejects kptr usage
> > here? Thanks.
> Didn't work for me.
>
> is_tracing_prog_type, despite the name, does not return true
> for BPF_PROG_TYPE_TRACING. Only BPF_PROG_TYPE_TRACEPOINT.
>

We can add it but return false when expected_attach_type ==
BPF_TRACE_ITER. For all other cases, allowing it doesn't make sense
because these might potentially run in NMI context.

Please let me know if you'd like to send a fix + tests, otherwise I
can follow up. Feel free to fold in the diff I sent into your fix, no
attributation needed.

> I'm honestly still not sure what the difference is, but they are
> different [1]
>
> Would you rather do this or just reject the dtors with a
> kfunc filter for this program type?
>
> Or teach the verifier that the kptr ops need to be offloaded with
> bpf_task_work_schedule_resume_impl?
>
> [1]: https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_TRACING/
