Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1373D3D16
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037613; cv=pass; b=Hb/N7ZQ3COfQYwQEosdo+BX+w7GDNsmY6R9Mng4AuMtVfssGSP96tiQZAqRwZgpn053JwkY/Lw7h1EwhpXQ3K0YT+PDP2zWZDXHazFkv3sD1Mjx7Cn7u6crQAc/WoQUGhyDn5iUvK7R43NsLacqU1s1ZSpWmXLifOb3+k7BzbKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037613; c=relaxed/simple;
	bh=2PEh1WESF3BGVoUAo0llKVx/EUAdUbTZWsfqV18G9kw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RSEgzbuX8YQ9g05i3QxUEM82rPYeOj8X1JeNckT7hWet/D927GFmk5/0eHcNtJoxYvZ7923nskGCiz6QDSZDHKeWV9fSiZhUW7Aip7urrvXgTg+KlnpaVBut3CSD5YdvQMbwohYYYewEbjqnvmh5gG4vozUG5S8sjaNrd/ML45A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhRXckAs; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhRXckAs"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4398ebdf520so686582f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:40:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772037608; cv=none;
        d=google.com; s=arc-20240605;
        b=WmapalyFPiBSt8Q9ddGcUq3RrE6xskhQbPrPuLdqq65eSqSGWpKnMG/UVOwyrk3yIh
         AnJDw9kVC+e3CVeDqVxM8ygQe+aKq5/YkC4i0dok6Hc0Fw3EF/laxkK/fu4VsWp27txC
         FXeWLnGbRB8N2AEJpnD6J3YF+o2kVlEEm3ade0uMlPkWFmcEnCZeFmRg/AfoY2+pkxmq
         bhkkfN2bCG0gM/YxHam9wDTON16meRoC5QsQTDJzAqhK7Pvx3pe1wM6JPZr5jEOLlLrC
         F6E8dJ/u5wvZX2ntC17vDsMsIn7tk6S1ANiCUb5MnhXaQGpPkI0BXpVCZhnpE5+patpV
         Lhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=abOUY+w5GnqeUS+kfj50B/qR62F95KVkgE0+o2VC2kQ=;
        fh=g4l5bN87s2wQrC1vCCcDcWNOYd8SLe/S3XRXJiOF+SE=;
        b=L/QPc1UfNJCk98uTrb1ULNmkmJKnhYacZqgswBG0MqinOeEoS3GaGeSUdm7webtPrb
         WJuc0pebgDFQwU4My2xC/tFU3pCphP629HFJFo6V7bp9RUtP9Zqv51KyjCeIuW4Sf7zZ
         How0uWhonn9LpiMSMBAQJFSEKJ1Tq5/GTEjYz1O9EY1iR9rbjQYx1GzRQGa9z5TB7VOI
         3B7Z06P8KjKiKG7QV3wXRfv/KpWqn+DEgOeAVd6rGHceXO1g/D1cpNa8EsUlPcpyo2G2
         NrHTqJfHWQKottABnuUVkV0vw+Wb9NXJ+L28r6yxR6FRSc8mBju+ZFOD9BckP0ODGYnj
         BvLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037608; x=1772642408; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=abOUY+w5GnqeUS+kfj50B/qR62F95KVkgE0+o2VC2kQ=;
        b=lhRXckAsJBzIvN4+sRV8r5iN1MnkFoCG+bAXd8wcJbePR7NYuTHBSp2+4IImj118Nw
         +sUoL/gXWIMmNPh5bVyxPUyQPMe0yr7zsdM5WkxsxnLeV+72hA6EF4pl01EBfiHtMoeB
         I0SyDmXNHkiZM4A5VJw0vuAN5WUV/Zph62Av26tHMmIpqUZhLCGamABWU+NsBEuYmTGq
         6ljRqJSAWJ79aHP3W82Q2/OX48jKuEuagSP5+alowLK6wpGYUZYSl68GRvtxuZj8SDL6
         O49PgW/7r/LqH9ngJPxYRzS7v74wjsnCQ7MOoiaTnSyeDTGRyIbD4FajwOicQM+vjw9Q
         4t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037608; x=1772642408;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abOUY+w5GnqeUS+kfj50B/qR62F95KVkgE0+o2VC2kQ=;
        b=He6hib3S3ngWqo5F+QOXxS+BA8yxPSq81TmF2EFkYDqNfroCQ9MeN6gQHlFNXRA3i2
         lfa4FL589AQ5uyXX4tXk6HFn8vG62SOAA1/gvLiBm1RRUZx09B4Tian7c/H7gLT8x8Bx
         1N7jdtjU7Qj03dIhIeHK2nKPAHrVPFV9L4wmDg0k6x2nkvAoRVUWHNVK9Qpw+jFSgpYD
         pJMt3WbL0M+MLG5SfTA2e6dpnVFLnERrZqKsdzkM1ZOYADEDQvauY2JmT7wcl6UMmezw
         4LE2A1950FID/xPHMGu7z6jmtrYRRen9N3JK6jrl7RHO9qjRt2WvJ74Ayi4ZlQ88H7fh
         N9Ug==
X-Gm-Message-State: AOJu0YwUNjWFeVaGuKsUFfhQqKxkwrkPsZYGmKQzzgFcpmeHrIutLifu
	SUjQ/ZBEbf88JrU4VLt2h0pC7GLZWvy7LUpo/nNkIGesgHreWZYJSD7XcMLVAb8Kl6Plv4BOEl3
	TevXcaSXQw/5HMXW3dHTomRUPvrrogAC7PIli7jw=
X-Gm-Gg: ATEYQzxIZMwe173IoZYhj8pVa2CUiyOaQ4Z3+rDdbfmdgzeSV7WKSySbvMWFj3T70q8
	Rt7+ISzuf2SzAWnBDJlliXXOeax57Kwa1uGBJfZwZaX/sEX1QE7qZ3iBs1qdVjFYDdImZGXH/83
	c9KrhnTohg4tTcH8ML9LiiMEQtOnsrfsmShpOO/waKbW8Mm14uqPop6YYFzDkUik7cmFbuBGBI9
	Z9urt4V3KhtGaKzPDmnrhOCJP+aLmVXu84JpK/TmaOX1IsKUcqa5CpeHQpSmkzxjR/X9ZACWDXa
	jqzbMoq/XDUled4h3n4jxbW/dbhYxmD6qdP7ooWeLvYZsFLTI8Y7HFVTLd3L
X-Received: by 2002:a05:6000:428a:b0:437:7300:eb1c with SMTP id
 ffacd0b85a97d-4398d965037mr7825079f8f.26.1772037607742; Wed, 25 Feb 2026
 08:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 25 Feb 2026 17:39:31 +0100
X-Gm-Features: AaiRm52hDvLF9-V65nZqmdINgbXuE6nMYaFwsUHpr9uxHLutG_s7daVXEVgLWe4
Message-ID: <CAP01T75xqwhGHzw8BTa8GXWJxq4OhJEx-O7CQvTuTUgxhJ70fQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Coroutines in BPF
To: bpf <bpf@vger.kernel.org>, lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

BPF programs today run to completion synchronously, since they
fundamentally represent a function that can be invoked by the kernel,
with a fixed execution context and execution time budget. A class of
problems we try to solve using kernel extensions involves stitching
together control flow across various contexts, separated both
spatially (i.e. in context, e.g. from an NMI to a task) and temporally
(i.e. in time, e.g. using a timer to delay execution of certain
logic).

At the core of these solutions is a consistent pattern of capturing
state pertaining to a given task or request (e.g. in a map) and the
function that must be applied on such a state to achieve some end
(e.g. the task work or timer callback), while composing all of this
together using lower level primitives to achieve asynchrony.

I would like to use this session to illustrate how this maps closely
to the idea of a continuation, and why we could benefit from such an
abstraction in BPF for writing programs that implement asynchronous
control flow. Such patterns can be made simpler to express, more
efficient at runtime through specialization, and easier for the
verifier to reason about end-to-end.

In particular, we will discuss the implementation of coroutine support
for the BPF runtime, by leveraging the C++ frontend in clang. This
will be a more concrete continuation of my presentation last year [0],
with a focus on the implementation details of the coroutine
abstraction, its runtime and compiler integration, paired with some
examples to motivate the need for such a primitive.

The session will be illustrative and open-ended, with some topics we
could cover listed below:
- Bootstrapping the C++ frontend for BPF (which might be of interest
independently).
- ABI between the BPF runtime and LLVM's coroutine lowering.
- Verifier changes necessary to make coroutines safe.
- Example use cases and demos (e.g., scheduling work done in various
kernel contexts, programs that operate across NMI/task context,
interaction with timers, etc.).

  [0]: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/Nous%20-%20LSFMMBPF%202025.pdf
