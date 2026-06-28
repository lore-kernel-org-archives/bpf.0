Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929539FCBF
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646788; cv=pass; b=cQbbChPqj7iBzfDjaeFP7z0QBCtKovp3GjDHWEfuMPM8dPnX6u0DSCg/f5RgdBKa8LrsLrXfaozezSf5h0I7cgt+quD0W/dwkdO4akEb9hyS59xQgMeWrwIGp9y428H0DJfVFeFbIJrsuja/FWBFsqXOHVbvnavnX0cyIqQDR3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646788; c=relaxed/simple;
	bh=d498hBMWdU3yNFxeg0vqz25RIl2j1GJoEg3MDJBpWnU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=od38bRevrsqCcbXuvsht5RwNOv69CIR0/2rpNs/HNYpfajdHjDUBoNVPbY022Ifju9m/BKkWwzQND8ndVLlZbAd8GwtQgs2JnpKGVdNK9woixdd29j9t5nRqmHRkWlzGe20niSVWBMk5INxVzSayrKj9Xp9olSSh/sKG+VwXX1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSTAZ+7B; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSTAZ+7B"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-463f1165e16so2499157f8f.0
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 04:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782646785; cv=none;
        d=google.com; s=arc-20260327;
        b=qI8ik+ZoA4Qw8/gRgmhX4AIxZkEpgaWBCOZVlkCvgrRntGP/bHBD9U5V1D7Fo4pLVx
         86Sowm+1Ftm/8dcl0ODhz0QZUOQoXag3dQeonpxalU25iMTZOOpSatsJwpmURoCZmF3K
         jeTkKB5as7iet3WQns/40+BnI4m41L20wZ3IXyZPafawnCRwi2EWfAbQfX8rzMWNZrk/
         xFiYODeSFLsyECoh/nPM3C/Aq74i7mSgsVHyKmZsWiXQAN1niLpskXUjUMS34e3Gje+V
         37NbuFEWqzXBNkSHirMEOH3dg4oZf0C/dgVOqIXu2ntSq4UMLYjlemRWhSg8hqe+Z8gy
         PY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        fh=t3evCTJwXzEEWG/jDHt/eMTtuIDAkmOc4mQH+Z00To0=;
        b=FA+t859UM/iHbJKUn1nQmjzjio/NUfEeO8C1DzfLeHVQsplU2ekdFfl7GG3p+TxtPg
         fY9ZuNMiJIWzrAYq7OUutxpMv7qusBm9rkEqBkNDQqJChizVZrxJMKzlsgrN20A0Z7Km
         9Gwxg5i29OPwyYkVG2OJ5fjGHn67pVQUhKcUBs87wIVkGGJwKPMhMa7B+FrFST5up/OK
         4hR78ePdf7dWWv7gZH9Gv3j1j4s/B68DnOkkCMi7BqF6+FeeUTq8/6nWgSqq60a976GW
         NF8oQ7hnkvfIpBikS+hudv99NJL3dKGK8JTuy2wmAb7aNY2+0X5XGleVR8gtnkyxmx9E
         aI2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646785; x=1783251585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        b=oSTAZ+7BUFaCqqvsuzotB8ngAQTb+rEB9zl8svMjzjB7b5h7hasER2XV466r4ynW2h
         aujKdUJNkJRAstFCxCptghu4IjH2l8NDqPEgvYnW+aAySXIuqXSRGUYLgMHyY6bOiYbF
         /w/QeRDgzVwUpr7bmoaVPu9yjR0vLM3259X2FTlgdre5aJ2+F4FaKK73xC63oWiafR+G
         W9OsuJh9SQ24W0GxgiJTSzUE5O+6gTImi0qVfS/2bfhgtN/X4zwfDQyTiW1weaiDKL5L
         tQBoYpfUXauZ+RNN+zeiYOnXaJlIiGuYIZ9AZTDXf2NAjj/N8pkwVT87FTxoT32nXMG/
         r+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646785; x=1783251585;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        b=l/CBus2V7RRVNq+tdJiq60nwJoT0zqydXM+3aXhLs/Rl2k19cwjkAhEvWIzu11tw0q
         e74Nix9bimbxVP/nKeFOABJkMMEtmHPedK1LdDCUt/RPF+mAKS+v2+v/H3qXlSZ4Izq+
         0jdzQ/qArCVGA8Mff/JNZiHO04MOmDPGemL8KWRLbcKICsvW3KG3qh6C+MEkpQrQro6x
         SIgKcihARcK+i3fh0JTkAmpIU2pforqctR8xA/z8eqYAEGFaiIkBvvUzjrHYC7yArapT
         nKVj00CbnYvkEZFt/tWR/Lb+2YF8zOk2VM94Po40bndVmlYCw8Ydz8fFYXEJqQ1Mb8H/
         E+6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqQlb1F2jhU9V88Dt0EQDuFru9xZ+wQv+Egj5X7G3OMlz9cF9+mhBxDeEOY2VwADDFin5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFECkaXS/SBtHo8rrKgFOYF9ai+Bda09newgy0IN45q0hkb3mg
	xotXVSK98m4ZVXZkHolKuHc4UBdMcrvCJ1jYMFW1hmwZ2JLD2KV5YMLFV1V8O277OKSbrGhHl9G
	Ot5PhKclqK+XC/xXQQuRxXSjYAlem7MI=
X-Gm-Gg: AfdE7cnzb7r+8wACdIIKN10AH7CVEJXKCehxK7PYv/1brrn2Jcevd0YnvioaAlTV5KO
	UsBFI1bhhwGPVOaczTXidRbJekquQPMCqBiWV1sTbbEI/0Jngeeu8P3pAtIkYre5fOj17SBhNrA
	54zqONSvef/FC8nl5FaGqm1c7BGYQysXVdIhWMZKy34NynC/8s2DwMigx5qb1df1MDqtEHMX23T
	t9Yan0FRLXI4XcC1bzZ6/l7FuStDyeCsZENuGFf/98vxAJbTXlvkKsUXF83w+LCdeBwtg==
X-Received: by 2002:a05:6000:40cf:b0:46d:1433:77ec with SMTP id
 ffacd0b85a97d-46dbf021840mr22541235f8f.2.1782646785414; Sun, 28 Jun 2026
 04:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 28 Jun 2026 20:39:34 +0900
X-Gm-Features: AVVi8CfDJaopmWM8eZVww041Hj-U2h62NQOVb61mCb6UmG7XUvpGHldL02uI0LM
Message-ID: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
Subject: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: leon.hwang@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I am re-posting this mail because I forget to add [RFC].

The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
"xdp: Add tracepoint for xdp attaching failure") exposes the netlink
extack message produced when attaching an XDP program via BPF_LINK_CREATE
fails. This is useful because, unlike the netlink attach path, the
bpf_link attach path does not return the extack to userspace -- the caller
only gets an errno (e.g. EINVAL/ERANGE).

We would like to use this in Cilium [1][2]: when attaching the XDP
datapath program fails, surface the kernel's reason (e.g. "single-buffer
XDP requires MTU less than ...") in the agent logs instead of an opaque
errno, so operators don't have to inspect dmesg on the host.

The limitation we hit is that the tracepoint only carries the message
string, so a consumer cannot tell which device a failure belongs to.
This matters for two reasons:

  1. Correlation: with only the message, a consumer cannot reliably
      attribute a failure to a specific attach, particularly if multiple
      XDP attaches happen concurrently.
  2. Scoping: a consumer watching this tracepoint sees XDP attach
      failures system-wide and cannot limit them to the devices it
      manages.

At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_device
is in scope, so exposing it looks straightforward:

  TRACE_EVENT(bpf_xdp_link_attach_failed,
      TP_PROTO(const char *msg, const struct net_device *dev),
      TP_ARGS(msg, dev),
      TP_STRUCT__entry(
          __string(msg, msg)
          __field(int, ifindex)
      ),
      TP_fast_assign(
          __assign_str(msg);
          __entry->ifindex = dev->ifindex;
      ),
      TP_printk("ifindex=%d errmsg=%s", __entry->ifindex, __get_str(msg))
  );

  - trace_bpf_xdp_link_attach_failed(extack._msg);
  + trace_bpf_xdp_link_attach_failed(extack._msg, dev);

Before sending a formal patch I'd appreciate guidance on a few points:

  - Should the tracepoint take const struct net_device *dev (consistent
    with the other tracepoints in this file, and lets TP_printk show the
    device), or just the ifindex as an int (simpler for raw_tp BPF
    consumers, which otherwise read dev->ifindex via CO-RE)?

  - For raw_tp consumers the argument order is effectively ABI: prepending
    dev would shift the existing msg argument. I've appended dev above to
    keep msg at args[0]. Is preserving the existing argument position the
    right call, or is reordering acceptable given how new and rarely
    consumed this tracepoint is?

  - Is extending the existing tracepoint preferred, or would you rather
    keep it as-is and expose the device context some other way?

This would be my first XDP/BPF tracepoint change, so any direction is
welcome. I'm happy to send a proper patch once the shape is agreed.

Regards,
Masashi Honma

[1] https://github.com/cilium/cilium/issues/40777
[2] https://github.com/cilium/cilium/pull/46546
