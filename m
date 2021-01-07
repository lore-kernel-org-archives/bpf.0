Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53826C433DB
	for <bpf@archiver.kernel.org>; Thu,  7 Jan 2021 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5023443
	for <bpf@archiver.kernel.org>; Thu,  7 Jan 2021 19:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAGTtd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Jan 2021 14:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGTtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 14:49:33 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF52C0612F4
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 11:48:52 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x2so7175874ybt.11
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E1uLkG7sTbcmoPVwABiVI0pp4U1RQFVKdDeAuyTcroo=;
        b=WJKbcyJsq49NtEPodvjTdtPSnlZfLV1CRRjj8un9lSdDUw7HP0yzj5i63AIA5dL+jc
         +NH58DkIsgUBcwlokjhECTndf1+6ieGJvWgNJGFdwZvJaGW54w4HTSr7YXQV09rNCnk6
         XunLj7uNjCsErpMw7C1eZXZel6X5SZ3oGx5K1LCNMb/UJ6KOmIFgVBmZ9mz3XAWdjsSI
         fd9QL+ZqAjuK28lmeDoMsA1CQe+cZ+w0zUFF6UqLmIOVelRu13C5X/FaJUCA2O2bXH8c
         z/ewYx9e9mEkRZGGMKjNa7EXI34hCgcSOG8Kqf31zL3tUJB6LlpIgM2zI4PLbqSJ8D7S
         ABlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E1uLkG7sTbcmoPVwABiVI0pp4U1RQFVKdDeAuyTcroo=;
        b=DzMhYMGxnQmxVmxjfLnxwpql4rlpa3v52rAeQ4S3Is/wFtHgX/893/e6q/WhRR5g2W
         vIPceNWjEYf4CA9QRUr3l3X1eDE/Km8TBvjEiDyUD9IbvcebdDlMKvJx84zqsyV0ZjCx
         fpYVzhSI/PB+9wYLSgu2MgOHJsW6KhDdSRI99riSNQSZsbCxchFZgOxs4YHNcn/HPUOA
         sBZmFbnA3GyvdKBzh/bqPnqC7GYPnALTOB+SYnYlWzSKr7L8zQvXEsVT8J6eRS47DaCZ
         4dDdvgit7VV1JLXilZ+eJvU9mbCslzwVtVn/7zjO3TnGY0niD/IIBptpZaMVKKZI9K+x
         q1Dw==
X-Gm-Message-State: AOAM531E+UoEweXxIefmefzilYBUmIn/tfiLgeaACj48tOWjloy53ln4
        BHCkV31XaylKkjF4ZWE1O5YsmVGu18MbHqy3xR8=
X-Google-Smtp-Source: ABdhPJwQQME8Has61QzhS+ZxrCSvy7iZPQ3f2qn4sBNQf7pU42h8/z4iSAWCyiMKZvXlCV3ul4qi9Cx30xboEp21UX0=
X-Received: by 2002:a25:2c4c:: with SMTP id s73mr635075ybs.230.1610048932008;
 Thu, 07 Jan 2021 11:48:52 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jan 2021 11:48:41 -0800
Message-ID: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
Subject: BPF ring buffer variable-length data appending
To:     Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We discussed this topic today at office hour. As I mentioned, I don't
know the ideal solution, but here is something that has enough
flexibility for real-world uses, while giving the performance and
convenience of reserve/commit API. Ignore naming, we can bikeshed that
later.

So what we can do is introduce a new bpf_ringbuf_reserve() variant:

bpf_ringbuf_reserve_extra(void *ringbuf, __u64 size, __u64 flags, void
*extra, __u64 extra_sz);

The idea is that we reserve a fixed size amount of data that can be
used like it is today for filling a fixed-sized metadata/sample
directly. But the real size of the reserved sample is (size +
extra_sz), and bpf_ringbuf_reserve_extra() helper will bpf_probe_read
(kernel or user, depending on flags) data from extra and put it right
after the fixed-size part.

So the use would be something like:

struct my_meta *m = bpf_ringbuf_reserve_extra(&rb, sizeof(*m),
BPF_RB_PROBE_USER, env_vars, 1024);

if (!m)
    /* too bad, either probe_read_user failed or ringbuf is full */
    return 1;

m->my_field1 = 123;
m->my_field2 = 321;


So the main problem with this is that when probe_read fails, we fail
reservation completely(internally we'd just discard ringbuf sample).
Is that OK? Or is it better to still reserve fixed-sized part and
zero-out the variable-length part? We are combining two separate
operations into a single API, so error handling is more convoluted.


Now, the main use case requested was to be able to fetch an array of
zero-terminated strings. I honestly don't think it's possible to
implement this efficiently without two copies of string data. Mostly
because to just determine the size of the string you have to read it
one extra time. And you'd probably want to copy string data into some
controlled storage first, so that you don't end up reading it once
successfully and then failing to read it on the second try. Next, when
you have multiple strings, how do you deal with partial failures? It's
even worse in terms of error handling and error propagation than the
fixed extra size variant described above.

Ignoring all that, let's say we'd implement
bpf_ringbuf_reserve_extra_strs() helper, that would somehow be copying
multiple zero-terminated strings after the fixed-size prefix. Think
about implementation. Just to determine the total size of the ringbuf
sample, you'd need to read all strings once, and probably also copy
them locally.  Then you'd reserve a ringbuf sample and copy all that
for the second time. So it's as inefficient as a BPF program
constructing a single block of memory by reading all such strings
manually into a per-CPU array and then using the above
bpf_ringbuf_reserve_extra().

But offloading that preparation to a BPF program bypasses all these
error handling and memory layout questions. It will be up to a BPF
program itself. From a kernel perspective, we just append a block of
memory with known (at runtime) size.

As a more restricted version of bpf_ringbuf_reserve_extra(), instead
of allowing reading arbitrary kernel or user-space memory in
bpf_ringbuf_reserve_extra() we can say that it has to be known and
initialized memory (like MAP_VALUE pointer), so helper knows that it
can just copy data directly.

Thoughts?

-- Andrii
