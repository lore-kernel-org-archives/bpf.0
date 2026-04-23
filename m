Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3120364055
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931658; cv=none; b=tiiwneBTB6xIrhZRN1AVHSaBJ4dfS08lSHDYVaQLbBTjFkW2WVvsyywCPjxCO1T10KPSFFt16lcSPNRAXQaeAT/87eo4hzeMF6t5oz/BxJANSQJGaBlWNFsil0uAuBh9w3iO7UB8uiRs9NOyjZG3AUrqt5i9M65fSSsCEuHD4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931658; c=relaxed/simple;
	bh=zLZgSAsPd504C1ubwqHeTrWS6irrTowIbXpgRn/M7fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=N8DDfgkhvRggEkCWfzdH0a/vy9kv2NWp1Hhzpl/Obdwx5l0+lBYR36J7zhKvce3dRwYJv5XlyrxflnTUGNJWkQKmdbhQED9RJnnB2cwRAt6Djl1kRsL1B6wrKojfPIwji9IySKiYN54X3kgN7bMX13LZFninrsbpTpxZ3bAIjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsZ8b25x; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsZ8b25x"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so2925991b3a.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776931656; x=1777536456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zjcV6/fPrNgYxtqaah+gchu8LmNW+4QZg718ruSLPk=;
        b=NsZ8b25xLMo9nPTrmFH8Sjt6YVBLyFcWcuP4GlgglwMq73TEVn8+Jb28JzJCsSwcS6
         jDJADYBsZAYoen6wjDLdqYif6M2BsLX13hRUCRt63LTeIJrppxuTEEmsv0AdCWkOqb1O
         WMNAPkbjEZPbBsvmeAZUWtKLEKclcghReqzcDWmUPjbkBwHWdx0aadMP7RZKK483lTjC
         wKERktt3U/PetfygHvvW8Efn76CgpYcNhQ/SuMBwdv53r1InZfcedCVaYlV/EtDp1g8P
         bp8L4UDGo7ZhJGwTaJUN76mrh4li7WBnQRRkNXhwnNXygw9ioEvRLUcdk5uWf4jbpJs6
         Fk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931656; x=1777536456;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zjcV6/fPrNgYxtqaah+gchu8LmNW+4QZg718ruSLPk=;
        b=m0KnZbl8pBDCc0ClnLeCZeqE011SgIzNPUOMqx14FEJoIAFgDVVoq/znv3HCaqo9tv
         +Mp0n1TyJBwPItBJH6Jctpp36qnhXD+08GUXk7/GN7qoaKr5w8p0kVEyWtNmHhX/BqjS
         LUFDdoENUwidI0yEBAIciHQNRD9h2UL1c5sPs1q7Dd/A094z8NTRyQbGM5KZNt5ZlaDA
         sE4XJA+ltVcv7koqWTF5MZdPel+6iCT/p184r36rDH38cgYvHYHgKhLcfLzg0HzBuKNm
         CIpO/mDBNdj51cQuby7t0KvN0mfUSE3ugOTIX34zmjwD16oUyXgzfGzA5SV0qhyIocDU
         JxSw==
X-Forwarded-Encrypted: i=1; AFNElJ8+7RrqdeOjIC0WC8gTsjQhWdUdHREMHiPLUBhPzglm31/AJTcHsJja0owbpMyHdgRHN0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tEJt3MfW/JMqX9fqDrVsn5OrfRxme3bAaEl0iQ37SvJM9/Ie
	bW/MTN+al0mhM362RlvnAyzsKU97CaFpgPgBSbs2SQ2nA2oZK5Q66TsU
X-Gm-Gg: AeBDievcpufZSLarIhUVTClfB8QItpfQ1YJfauBxe0TYjDAVjsNGzV14aesKhcXmRIt
	0cDLvnHQ0yhS1njNLLEIf3TfunhEuydDqB11IqqEquqC0OOo2s2sjLNG6tDvW52lRXpHA65fr6z
	pCivy8Qn2Ruh1RFQ5jWPFPQrzxdlt8ICFsygPOhSMjX0WYeaWsX8ne+a6bpU9eKeoOvUP6E+H52
	ZP9XXeMCSoBPSfOmX03VvlZxyINZhUMfSKgaeDmrsRO/6hxdteV9zvVmXvumLnlDOXLwbHVX7vG
	RD/oWOaiI6mjRi4jhT0pzD5ZfmVogEf0fH4hUSTDzRHybcodC7Ta8TL7z36f3KvBQ4wR1NdTHZj
	c8XVbMBmo+AKffptnXzoUKYgmvyhe0cghxEx5YEittwFtro96u9KfdemClDUxytNfdO9ekLgGJW
	9iIMCq4+CNrvaqP72Qaw+typ8yKUd6+8gucHngPg2TwWMLynVHTKEiYqzJijucpN9cJQ==
X-Received: by 2002:a05:6a00:4b4f:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-82f8c94401fmr26438968b3a.35.1776931656138;
        Thu, 23 Apr 2026 01:07:36 -0700 (PDT)
Received: from localhost (vpngw1.cse.cuhk.edu.hk. [137.189.90.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3f31sm24238215b3a.37.2026.04.23.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:07:35 -0700 (PDT)
Date: Thu, 23 Apr 2026 16:07:24 +0800
From: XIAO WU <shawdoxwu@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, clm@meta.com,
 daniel@iogearbox.net, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 jolsa@kernel.org, kafai@fb.com, linux-trace-kernel@vger.kernel.org,
 martin.lau@kernel.org, menglong8.dong@gmail.com, rostedt@kernel.org,
 songliubraving@fb.com, yhs@fb.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 10/17] bpf: Add support for tracing_multi link
 session
Message-ID: <20260423160724.00004f6d@gmail.com>
Organization: CUHK
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
In-Reply-To: <0520af2c467a82b82aa3014b7e721f95bfde9e91324bb2e183b099e5a37bbc3e@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> BPF_TRACE_FSESSION_MULTI is now accepted here, which means
> a program with this type can enter bpf_tracing_prog_attach()
> via BPF_RAW_TRACEPOINT_OPEN:
>
> bpf_raw_tracepoint_open()
>   bpf_raw_tp_link_attach()       /* name == NULL */
>     bpf_tracing_prog_attach()    /* BPF_TRACE_FSESSION_MULTI */
>
> Further down in bpf_tracing_prog_attach(), the fexit node
> initialization only checks for BPF_TRACE_FSESSION:
>
> kernel/bpf/syscall.c:bpf_tracing_prog_attach() {
>     ...
>     if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
>         link->fexit.link = &link->link.link;
>         link->fexit.cookie = bpf_cookie;
>     }
>     ...
> }
>
> So for BPF_TRACE_FSESSION_MULTI, link->fexit.link stays NULL
> (from kzalloc). When __bpf_trampoline_link_prog() later calls
> fsession_exit(), it returns &link->fexit with a NULL link
> field. This node gets added to the trampoline FEXIT list, and
> bpf_trampoline_get_progs() then dereferences it:
>
> kernel/bpf/trampoline.c:bpf_trampoline_get_progs() {
>     ...
>     hlist_for_each_entry(node, &tr->progs_hlist[kind], tramp_hlist) {
>         *ip_arg |= node->link->prog->call_get_func_ip;
>                    ^^^^^^^^^^
>     ...
> }
>
> Would it make sense to either add BPF_TRACE_FSESSION_MULTI to
> the fexit initialization, or reject this type in
> bpf_tracing_prog_attach() since it should only be used through
> bpf_tracing_multi_attach()?

Yes, confirmed.

I reproduced this on x86_64 with a minimal tracing program loaded as
BPF_PROG_TYPE_TRACING with
expected_attach_type=BPF_TRACE_FSESSION_MULTI, then attached through
BPF_RAW_TRACEPOINT_OPEN with name=NULL.

This reaches bpf_tracing_prog_attach() without initializing link->fexit
for FSESSION_MULTI and later hits the NULL dereference path in
trampoline handling, as you pointed out.

C reproducer:

--8<--
#define _GNU_SOURCE
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/syscall.h>
#include <unistd.h>

/* Use kernel-under-test UAPI, not host's potentially older one. */
#include "../kernel-source/include/uapi/linux/bpf.h"

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static int sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
{
    return (int)syscall(__NR_bpf, cmd, attr, size);
}

static void bump_memlock(void)
{
    struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
    setrlimit(RLIMIT_MEMLOCK, &r);
}

int main(void)
{
    bump_memlock();

    /* r0 = 0; exit */
    struct bpf_insn prog[] = {
        { .code = 0xb7, .dst_reg = 0, .src_reg = 0, .off = 0, .imm = 0
    }, { .code = 0x95, .dst_reg = 0, .src_reg = 0, .off = 0, .imm = 0 },
    };

    char license[] = "GPL";
    static char log_buf[1 << 20];

    union bpf_attr attr;
    memset(&attr, 0, sizeof(attr));
    attr.prog_type = BPF_PROG_TYPE_TRACING;
    attr.expected_attach_type = BPF_TRACE_FSESSION_MULTI;
    attr.insn_cnt = (uint32_t)(sizeof(prog) / sizeof(prog[0]));
    attr.insns = (uint64_t)(uintptr_t)prog;
    attr.license = (uint64_t)(uintptr_t)license;
    attr.log_buf = (uint64_t)(uintptr_t)log_buf;
    attr.log_size = sizeof(log_buf);
    attr.log_level = 1;

    int prog_fd = sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
    if (prog_fd < 0) {
        fprintf(stderr, "BPF_PROG_LOAD failed: errno=%d (%s)\n", errno,
    strerror(errno)); if (log_buf[0])
            fprintf(stderr, "verifier log:\n%s\n", log_buf);
        return 1;
    }

    memset(&attr, 0, sizeof(attr));
    attr.raw_tracepoint.prog_fd = prog_fd;
    attr.raw_tracepoint.name = 0; /* NULL name drives TRACING attach
    path */ attr.raw_tracepoint.cookie = 0x4141414142424242ULL;

    int link_fd = sys_bpf(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));

    if (link_fd < 0) {
        fprintf(stderr, "BPF_RAW_TRACEPOINT_OPEN returned errno=%d
    (%s)\n", errno, strerror(errno)); close(prog_fd);
        return 2;
    }

    fprintf(stderr, "Unexpectedly succeeded: link_fd=%d\n", link_fd);
    close(link_fd);
    close(prog_fd);
    return 0;
}
--8<--

I agree the patch should be made bisect-safe. I will post a follow-up
that ensures BPF_TRACE_FSESSION_MULTI cannot enter this uninitialized
fexit path (either by initializing it consistently where needed, or
rejecting this attach route and keeping it exclusive to
bpf_tracing_multi_attach()).

Signed-off-by: XIAO WU <shawdoxwu@gmail.com>

Thanks
