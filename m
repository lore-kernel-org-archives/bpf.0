Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DC348463
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365897; cv=none; b=T0DmwmvfldlybaUAiuFKbD5gT8GIHNR3S45ryZP2aO+4Iepj++qesKJ6I3/RxpcJsNF/XawOnKTP61BXyScjmpOg9TmkhciQgBS6Tro7FvR/Wf9u1uhbPBcg6mHWR5u9Uphjx2KvnC368aZSnKsuemkGaadgug+Ec2qr9w0t5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365897; c=relaxed/simple;
	bh=NF2RoQmb6QlJBUEA92etllq5rKJsin8K65H55vhDGDw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aACx6yXhpQvD7i4rDsEpJjfevE91SW21vWIs74BRvYgiEpVDfIsTRxMsTV5M0pV3i1D6QZZFFzhFhhk5nOPsNbZxkjFuINhBtNV57uMkoRpNdBDbLYWor8KYRL/ApL8Ku9xf1uU3UKcJ0Va9eMHkOwu4YhcFMt1f91lxgrHEbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf5BMv7H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf5BMv7H"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so4560035e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 00:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770365896; x=1770970696; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7rZZ9td+PEg2iEzon3pHhYXGMk+QVxYQN8xtkEj6STo=;
        b=Bf5BMv7HbXYDkCIySCAiSzLVKaXaB30STCpivYIR5gBQo/HqBYjHPsbKFav9v3Rtp1
         Yh2mxk29vwW1Fb0Rjt/bZ5kUsCrCtLqRpVP3lgY/RAKc9CAdLQAPwSdpqLT48JkVzywf
         Y1pikTFu7aaMjateV49JjVQZYp5Lx7SgQOYO5NZAXGmxODhr9W6krNr9NGTvJZctIO/G
         6mwjQ8lJD8dbrUsO2U2wP1FTbv/CZm4cQaQVyZniBd8oEO1Zcn1kHbl/UDUaTudCTq/9
         n2x/VvdGw5pfF1VOoUPb4deFW8TUrrkD9E9uyTxCf3kyZcDgKgFd4v4jGknEAHhywoDP
         NTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770365896; x=1770970696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rZZ9td+PEg2iEzon3pHhYXGMk+QVxYQN8xtkEj6STo=;
        b=ndqmWSlDlDIWvPU2KosbNdxjlIlluiYV8MAzmRfYB1AEBOZZZNqCgBjvvxn+BpqB+r
         ap18BB4zxNsl0gHAunLbsuXFM4LR3+22oVX0OL58hqyRwj7ADj7cqAHczTTx5WIIRsMo
         FVxcS3uLdTLU9QHWqk4lrAYQ7FlELbAgyC++sKaV6gMUB6XogZan9B8VDPytC42/ama/
         22qpsP2aUG4ctN8FBUS6lJLGLYEkpmLCFzKpa0xTOIC1xbPRBxahiR7+AReSMPxCQbOh
         HnNWurM/LBkNYE+tvvMPu/QUaShpGvJOEJLq7xilA3mB6coTGVW21ucsgkInFSE3yOrM
         u9vw==
X-Forwarded-Encrypted: i=1; AJvYcCWHJ4lZ5QH/UNYBzpu+AsSBlPktBIxIlJIyR3IYuRXPDjxkK9DnKtvO+V+rkE26feGf2Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMwWqCGJog3Nt05MnU5jBym3bp3Dz86b1Ot+0FA4vCg0UmgXR
	PgAnJoh2nFjpXv1Kaqcmb1w0dsb82lWBikH30bc2KO+NB7ZWMhQsVij9
X-Gm-Gg: AZuq6aKvLA6NAzT/9ZFhHtOcVnCbGbI8ms7wCGAPOZxQVY4seXArMk4prqSJW88yS6f
	v+1ffw/zLWbRfdck8gYGWtUqOJekk0M6nqGaNIhxOrHHwPECXibYEzqLAClm4XH9njSwOiCnY5z
	YUGrJv7oey2b8DlcoWtqWEC4cEAvyPwAeQB5vcSUpsz4D3iWesbAJc7kXBVOoMYTSiPksZQeBAd
	pcHX++6l1o0bmMxpaDfbXyhnvQs0d6HlGCtvbhyT5+C2sKvIBPuAOIoj2IFBupsliJQwBPKaPFZ
	2tU1B3S+gtR+bbiG7O7vnE00j3tQd9OQVYDBCeTyfBsLkA3kvd6/OEXQ60Rtn2uB/fNvFZe9R6t
	141iiax6G5f2jyICActyNM6isIEhvnmEZgXqBqdAaDj8JtuCWNhd+ii6sDIj5
X-Received: by 2002:a05:600c:a416:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-483255d164emr8045375e9.5.1770365895856;
        Fri, 06 Feb 2026 00:18:15 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209c1a64sm12694935e9.12.2026.02.06.00.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:18:15 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Feb 2026 09:18:12 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
Message-ID: <aYWjxMeXABGcYqEI@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava>
 <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
 <aYRa_CDL1RqIR_8S@krava>
 <CAADnVQLJJn=bSDvQrjNyyeNdLOZABKDjjR_3j6DG3pgbsJ+JXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLJJn=bSDvQrjNyyeNdLOZABKDjjR_3j6DG3pgbsJ+JXA@mail.gmail.com>

On Thu, Feb 05, 2026 at 07:55:19AM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 5, 2026 at 12:55 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 04, 2026 at 08:06:50AM -0800, Alexei Starovoitov wrote:
> > > On Wed, Feb 4, 2026 at 4:36 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > > > > On Tue, Feb 3, 2026 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > >
> > > > > > hi,
> > > > > > as an option to Meglong's change [1] I'm sending proposal for tracing_multi
> > > > > > link that does not add static trampoline but attaches program to all needed
> > > > > > trampolines.
> > > > > >
> > > > > > This approach keeps the same performance but has some drawbacks:
> > > > > >
> > > > > >  - when attaching 20k functions we allocate and attach 20k trampolines
> > > > > >  - during attachment we hold each trampoline mutex, so for above
> > > > > >    20k functions we will hold 20k mutexes during the attachment,
> > > > > >    should be very prone to deadlock, but haven't hit it yet
> > > > >
> > > > > If you check that it's sorted and always take them in the same order
> > > > > then there will be no deadlock.
> > > > > Or just grab one global mutex first and then grab trampolines mutexes
> > > > > next in any order. The global one will serialize this attach operation.
> > > > >
> > > > > > It looks the trampoline allocations/generation might not be big a problem
> > > > > > and I'll try to find a solution for holding that many mutexes. If there's
> > > > > > no better solution I think having one read/write mutex for tracing multi
> > > > > > link attach/detach should work.
> > > > >
> > > > > If you mean to have one global mutex as I proposed above then I don't see
> > > > > a downside. It only serializes multiple libbpf calls.
> > > >
> > > > we also need to serialize it with standard single trampoline attach,
> > > > because the direct ftrace update is now done under trampoline->mutex:
> > > >
> > > >   bpf_trampoline_link_prog(tr)
> > > >   {
> > > >     mutex_lock(&tr->mutex);
> > > >     ...
> > > >     update_ftrace_direct_*
> > > >     ...
> > > >     mutex_unlock(&tr->mutex);
> > > >   }
> > > >
> > > > for tracing_multi we would link the program first (with tr->mutex)
> > > > and do the bulk ftrace update later (without tr->mutex)
> > > >
> > > >   {
> > > >     for each involved trampoline:
> > > >       bpf_trampoline_link_prog
> > > >
> > > >     --> and here we could race with some other thread doing single
> > > >         trampoline attach
> > > >
> > > >     update_ftrace_direct_*
> > > >   }
> > > >
> > > > note the current version locks all tr->mutex instances all the way
> > > > through the update_ftrace_direct_* update
> > > >
> > > > I think we could use global rwsem and take read lock on single
> > > > trampoline attach path and write lock on tracing_multi attach,
> > > >
> > > > I thought we could take direct_mutex early, but that would mean
> > > > different order with trampoline mutex than we already have in
> > > > single attach path
> > >
> > > I feel we're talking past each other.
> > > I meant:
> > >
> > > For multi:
> > > 1. take some global mutex
> > > 2. take N tramp mutexes in any order
> > >
> > > For single:
> > > 1. take that 1 specific tramp mutex.
> >
> > ah ok, I understand, it's to prevent the lockup but keep holding all
> > the trampolines locks.. the rwsem I mentioned was for the 'fix', where
> > we do not take all the trampolines locks
> 
> I don't understand how rwsem would help.
> All the operations on trampoline are protected by mutex.
> Switching to rw makes sense only if we can designate certain
> operations as "read" and others as "write" and number of "reads"
> dominate. This won't be the case with multi-fentry.
> And we still need to take all of them as "write" to update trampoline.

this applies to scenario where we do not hold all the trampoline locks,
in such case we could have race between single and multi attachment,
while single/single attachment race stays safe

as a fix the single attach would take read lock and multi attach would
take write lock, so single/single race is allowed and single/multi is
not ... showed in the patch below

but it might be too much.. in a sense that there's already many locks
involved in trampoline attach/detach, and simple global lock in multi
or just sorting the ids would be enough

jirka


---
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b76bb545077b..edbc8f133dda 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -30,6 +30,8 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline tables */
 static DEFINE_MUTEX(trampoline_mutex);
 
+static DECLARE_RWSEM(multi_sem);
+
 struct bpf_trampoline_ops {
 	int (*register_fentry)(struct bpf_trampoline *tr, void *new_addr, void *data);
 	int (*unregister_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr, void *data);
@@ -367,11 +369,7 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist_ip, head);
 	refcount_set(&tr->refcnt, 1);
-#ifdef CONFIG_LOCKDEP
-	mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
-#else
 	mutex_init(&tr->mutex);
-#endif
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
 out:
@@ -871,6 +869,8 @@ int bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 {
 	int err;
 
+	guard(rwsem_read)(&multi_sem);
+
 	mutex_lock(&tr->mutex);
 	err = __bpf_trampoline_link_prog(node, tr, tgt_prog, &trampoline_ops, NULL);
 	mutex_unlock(&tr->mutex);
@@ -916,6 +916,8 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 {
 	int err;
 
+	guard(rwsem_read)(&multi_sem);
+
 	mutex_lock(&tr->mutex);
 	err = __bpf_trampoline_unlink_prog(node, tr, tgt_prog, &trampoline_ops, NULL);
 	mutex_unlock(&tr->mutex);
@@ -1463,6 +1465,8 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	struct bpf_trampoline *tr;
 	u64 key;
 
+	guard(rwsem_write)(&multi_sem);
+
 	data.reg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
 	if (!data.reg)
 		return -ENOMEM;
@@ -1494,12 +1498,10 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 		tr = mnode->trampoline;
 
 		mutex_lock(&tr->mutex);
-
 		err = __bpf_trampoline_link_prog(&mnode->node, tr, NULL, &trampoline_multi_ops, &data);
-		if (err) {
-			mutex_unlock(&tr->mutex);
+		mutex_unlock(&tr->mutex);
+		if (err)
 			goto rollback_unlink;
-		}
 	}
 
 	if (ftrace_hash_count(data.reg)) {
@@ -1516,11 +1518,6 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 		}
 	}
 
-	for (i = 0; i < cnt; i++) {
-		tr = link->nodes[i].trampoline;
-		mutex_unlock(&tr->mutex);
-	}
-
 	free_fentry_multi_data(&data);
 	return 0;
 
@@ -1528,6 +1525,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	for (j = 0; j < i; j++) {
 		mnode = &link->nodes[j];
 		tr = mnode->trampoline;
+		mutex_lock(&tr->mutex);
 		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, tr, NULL,
 			     &trampoline_multi_ops, &data));
 		mutex_unlock(&tr->mutex);
@@ -1550,6 +1548,8 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 	int i, cnt = link->nodes_cnt;
 	struct bpf_trampoline *tr;
 
+	guard(rwsem_write)(&multi_sem);
+
 	data.unreg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
 	if (!data.unreg)
 		return -ENOMEM;
@@ -1567,6 +1567,7 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 		mutex_lock(&tr->mutex);
 		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, tr, NULL,
 							  &trampoline_multi_ops, &data));
+		mutex_unlock(&tr->mutex);
 	}
 
 	if (ftrace_hash_count(data.unreg))
@@ -1576,7 +1577,6 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 
 	for (i = 0; i < cnt; i++) {
 		tr = link->nodes[i].trampoline;
-		mutex_unlock(&tr->mutex);
 		bpf_trampoline_put(tr);
 	}
 
