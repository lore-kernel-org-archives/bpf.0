Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E6334681
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646425; cv=pass; b=lKkGbkTPLGjdqtrjwSA8QE45LMQpHarTeeRZFOiN1bb9vAi180420qitjvaQWvUNqA4K3zD1B6rS8W+fGMY/KbUG9p4jCOHlungbo+nk+1jvTi2aW6NCZuQo1Xximw2MFGZ7cmOhzHI8XJN/DT6TKijkQa72zOc6uB3/z4z/pos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646425; c=relaxed/simple;
	bh=bgfpN079ZTjkfGSzvnJl3HzKuIyjV75/HikjUo6F6JI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ku2GSMhauJuuwMVxMOQCfWVKTT9SbTWxRen50A8witgL+z/LcU7J5gwCRVGaa//YfB+hWEOnuZ0mkIWBb3EBw1U0Iimsg51UywRSMDzbT/BBtdWEhhy0CVa6+9RzhmCQhkoY+nt9lQP6sAcD281zNj/6CTI0Qw/CPjTa9so/Yyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpKJajIp; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpKJajIp"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47248615e4dso644516f8f.2
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 04:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782646423; cv=none;
        d=google.com; s=arc-20260327;
        b=EbDzo8eQ9UXLBvyXKuM6eR8N2Y1O/YRr31KF6r/BzLxfenOB6uJnaHwefZRlhI9cYb
         AXsMfqmlmqBtac/qYUPvdjYzUduQEbE4Pvg1Lc0snVS7yyifBN9fC1Jd6TxDaNbBt4mc
         6xIltOOTS+VjB7lUt3Ykhfm5QVtWlLWO11CFf1SGmzefdVupwYNtSzNetYrWhSfHzhFm
         TU34CiAcSkE7loQ5xUzmUTOdHF7xxyDLqpX/3PWkc6wZklhaigvUEj+Oa1d/LBLJ+VH4
         iYyu6pvPYt2+E14vG3Mpx3T7SyQEHa4sG3RcigIrbUvTpUpiq4DkJ04q5tFntLth+Jn0
         ETMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        fh=eWriO86QW0bFXZjlcHmZvJgWj2GedKTCmpKu4aDA9/Y=;
        b=UltQmJi7QXy65Y2wMvWLIWFesVmZ8WKygu+WNbQdA3quCNQqAiLt1Xeaq2efU+KrRH
         mH2/IGEtGFM2q3I5xuz4O8kwxtNwJTKFZSz6m+bRqFSuVMwrbOS2gqGXwVuVLfZ3gCxg
         Rfio3RY5MwuLoDFvDMwQF7TKiBBQuJQBK5Tdv1YrnrEWeV19R9RoZbMWL77RRnQZESc5
         z+KQ02g2vuIdRQE6nKHAGsQANkbn1Doztc3AWBiGR+FtBeW7r/83y7orGXl9v7OqrVa3
         FLoDwxUd4RlHJ/JPV/VJ+/RErnfWzeG8K6fxMzF//67X5ABoM69q/gck33vPn+3lCNR9
         8d6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646423; x=1783251223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        b=JpKJajIpQ0FsXQUjKhtdpT3iBJKQSG165IVyQXjfxsUhliJGJNWIPAZTUBpR89tEn6
         H2KbKu0pdQJMavGl9T4mRFD/AnmSdewRUk61h87UCuGx7In2VcJLio1PRkbCtBR/gmJ8
         Jbdbd6rkYcCrmaU0jrWq2dffI6HzdULitCNKmdw71Ro4f+P7KW65jPC6eYhMsg16G9bi
         lEPGfBk6RLrg7yrhNP/+rQTuBXYVbo1kur2+03a1gHnXiOTxPSjF+Z7PUuuhQjpmkHIY
         j7BFIP4K70FYuyYgqCiKysNbGPq2eNwB9tY80qeecK8s+Xvd+6ZZtqDg1MfC6SRgXkQw
         K3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646423; x=1783251223;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        b=dsWaNsoqYYgfA4Bvlx0kPjLADkL4NjpvQzyFwWGG+E8uY27W5rEZ3MVgHhiD3alMEq
         jpux+63x5a5twXXYB7E5I/vSxYKXEZzDmyikkfW/MaFEqY166XoPO0ZPnQImD8lkpPyO
         9jPgsovu3E9CKKpiefmhnDC9YJZ8o77ikt/weG+Yi4k1pWMYmUQrcOCWyMtzC9DMjooh
         2ezGRw+/UBlCvGD/N2WEMbNa5Xe3aGSKLj+K7QDHo41WJRr+qEVZn1eNolPaFpxpOAjK
         I0M8FkMFNNuoZMIILXP/c/hBrg9eDNtDdrB2bg3X8g5aFoRJEmLgRPASB2U2G5hjqhO2
         +0Mw==
X-Forwarded-Encrypted: i=1; AHgh+Rrv0ZTFFR93KZpo1GL07Y3xRxJAN3FeSk9rc1TIhFX4u3fSS1XADSNHIqj+y8itvSwl0Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBgklZ7mcEOzcoTzTX3tqORWdqna63axmH9C7yd0cP+l2BOp0
	5jJhPZe6myM6+hZvYmx2AfXrtmF/y780HlKbA3GxgovO/K6IDV36rWQZ7RYu+UHLz+pCygN3pD1
	bl96IT5PFeAdJujdT9mIf3xVhIpTAdfY=
X-Gm-Gg: AfdE7ckW7+RpTXldrbJ1kwW279k8Q1Rijmio3rQ/91n2PCEaxTi29Vce1A/vg0LvffK
	KCb62pmpg6usxxaf2gBigV/jyAZWkGnuj0IosQ5zeRplV4VDd4PzxG62f8gJ7Y2IZqZCBxmsTPD
	NYyoGdWUZ/3ETv7ova3Q/3Hlw4WRxS2Sfj/R0Oes8GgSiFUTfY/PIkNEKU/8Wkyn/6TPgjMVeoG
	V+44/Z7TySKXpChNhswwgkqJu6WAdm7j6cBUugMmyBBgkXwZE28WpUa0vQxA9pviKSfqA==
X-Received: by 2002:a05:6000:3111:b0:45e:f684:7347 with SMTP id
 ffacd0b85a97d-46dbf7d1bc0mr22070830f8f.12.1782646422449; Sun, 28 Jun 2026
 04:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 28 Jun 2026 20:33:31 +0900
X-Gm-Features: AVVi8Ceiv0d_3j-P-e81X83o_swUGxL0tFzZtYhSLjCxBgrq_DUpuk-krqAYxbI
Message-ID: <CAFk-A4mcCfNBWLw-rMAnC25k8LV6fF2_jGyhpKciFZv35koy8w@mail.gmail.com>
Subject: xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: leon.hwang@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

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
