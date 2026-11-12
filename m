Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499783;
	b=mwp4BrN6pVSeASSq4M07gOQ2YBPMFxG0HuSzxo71Kx9Vq0b2cI7RlTpNopLabXqj/ErF
	 Qc2vWRUUucOZfAUy/GT+kXy4W68Nk/OsrIwcZ0zLIq5nQj4wPmfdytUAFA9M1J6+8VKDV
	 XMmFCmwRuP0YENdKftb+SWZ9jBRT/im0Z5RMz5LLAMt3KfUbbLZ1qqAWwkjqHMYdoXXYY
	 cZt+G/zaHUXHhXSjwMc+LQxMdg6a3/tMLf7FrSY3IxPDVzCDcr9kNw0b8q5+QD3hVpCMD
	 T2aNxK71ez5ET+x6Tg+L/k4uXMQC2MRCB4jlucK8wzLPPwXlNRS4skv66yHzx19nxhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=N0ZJsqzR/c1fZDYFNq43Ai9ghBTFqYNHBo+RKWJmWtA=;
	b=IWcd0kYnZXvVoTuGBuucJZK0olqCugYjPxehY6j5RSyOTN8Ass/ERhbuPAQ00mjKeHPy
	 m0lQp+hFJzrl5jBViYArJWPnta4TjUiZmPjXYtc+jscXpY4AbdX8FxhexL4JB3ScKtuxw
	 VBP5p+MOFYkeAXnUUEnaMxaOHErZYY45HjQ5ecloeNYbjyZsYV45xlok02GOmkiqqIObn
	 3iILA/bv2VZiD+T/Fwc/FTQ+oTh18zsQZoqtNlqW3i8B6GPkzQ+Ug1JoaqVEBqZQBOHuj
	 CpzfbnvHoVAjbXUMaaNDFTIq1hwdciAtBu0ueVwwUayhxDyARBB726O6byhnH3uuoEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HkqPvzgK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA8606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0EA8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HkqPvzgK
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3aced9804e8so39650001fa.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:09:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499781; cv=none;
        d=google.com; s=arc-20260327;
        b=CHDHUCJaECws3YpvJG5RCwajPDRu+IjJwn4Jt9IKS0LXMECqkWO1k8rcP/IYdaEG+8
         oY+gGcCo0fZ8ieqkg7Ml7eDgOOvnJz+epzVBdkq9e3r7jMYkT9IEmMCcTWcjgbdo9EBq
         XgBprWlTiISDCJbJhz15HTyQYi/971aRu9gP3vdRJm99HpfAlYjwggsC+k718I04P+gD
         1FBdGPo/eAhUqUF5vdvrHo326psjTeDOrE90kvZoEGSKJLHO3J9brPCOCViQD2C9Nn/2
         7wpfsp+9+l8qWxsbFjstVbXl2/1McRJ+Oe8kbfQNexwGTBgC+H3ZJmVAsHhIJ94hoI67
         aHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N0ZJsqzR/c1fZDYFNq43Ai9ghBTFqYNHBo+RKWJmWtA=;
        fh=jZEpmanWap+k6u3rO4x22YyKckhC27G1Xqqsj0PrZbk=;
        b=fxaH+AAGrl4V+JWLFRD1uM4GKFsAlcEx/5zpTPcAbTHHT6MW46qmqmpKiEsvmzzvh1
         L1ce675LNp29IZwlS7yeQjQxzXuhmW7+3I9CvboX4bw+jao21bgaeO+lsl+JjgBYdfgw
         Ql8rxq2kVCWl3Fkk9w9Bk21XWONuSIo8H+xMAjWfY5t/jv1AwtH7QYKwz6xFNIH3wATV
         uIqUIU9O8tpqRDK6WxP2g60JTnxEckEzgwsDxHjOc8TKEtycxJdQRHLxm0iLd4lhs/Lw
         f14hzEskcvz+kRuTyftuzWM/L26C/dAhsuY0MnD2ZZJHK2lrOflYI9yoe23soy1ET/Tx
         a1CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499781; x=1795104581; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0ZJsqzR/c1fZDYFNq43Ai9ghBTFqYNHBo+RKWJmWtA=;
        b=HkqPvzgKP+XCUjGb45k5wH4PkzaSBqWf6dBWgk0ZPwgu5mjatfBJgkb/nRdfPtnvnk
         WQukZc9APT4+HCR/O2epMXl0JnrGpDgUu5N8LlceEMG0F3w2EzV92AB0m/Rt2YdHYK1m
         fegfo+zKJcpIXvlg2wZBNp2dtyCZaj0FygWez2KxNgsrl2BhZB60F5mRoshL+ddafpJH
         Tu8cZz42LUNEEWud1TRxhMAs5VWIV2aROSCwzvyeJJ7FH2o1AhyfIuwXviocNoyuing7
         GEoJ6L9RhBx84Vpo6/qHHHvDKPFS9fKY02zbltvgytt9IEzYuUEoBek58+LA7SbFoqpk
         ++2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499781; x=1795104581;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N0ZJsqzR/c1fZDYFNq43Ai9ghBTFqYNHBo+RKWJmWtA=;
        b=DfoCzL7qsDL8n58MyXglw33QbcNGpnClMj34MjcMJKYBy/Do9zenF1I1r47x1+qx/T
         qxBWu33BUYAYmVI3rewHECPxeegkPD/aMu6LNnwjHuYbmhArFn4JW/0xcZHGOujg2Qc7
         oxNZbRjkYf1WlHEjKqzb07Mrkgs7x0WFhdpIr1aNh3Q3y5p/NF1008SK5N0MrZsZP0Sn
         CfYpyy1Nr/8S6xKtme623WrfgjFFrBZwFZJGknjgDKTsm/jDV/BtDHE7X9A2eBBWtDXj
         jHJoDOgCmsTnKm/ThlbfnDTOQIl6BjiUHYyADNqZxcIkU/wuiz1vW49O4DbUpRnQLUH+
         4oAw==
X-Forwarded-Encrypted: i=1; AL+hErElfYDWuM6cm1wgdDwhxIvKCTHEkSecSgGpwAcIVhg33qwaI85t+X0WEO5AYLvUi7GE+Vs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ReJqKd3rBzIsNan3ehtXE4YYM1v9I7DfjIllbK1iv4YboGl/L
	XKqX5juCJsgj+gZg0T8fxgMNRgzZLhpvJZyj5sqCaJpoETk7q/aah4nUSX6ur8DzIvQDhAu61IY
	G0K5LLdu+oz0rIzuyCkxSyYo9+pab608iOw==
X-Gm-Gg: AYBFou3ONAv26AW1mOocy0RA6owT8UKdq07hGrAvpiWHgrRdUPir2ZsPaxhwsXRARfF
	hdnjMvTN7totmuEYGaVX3OJkp+i8K5ECCiXM16LzHcvq4RuqnsX3uMtpQEa7H97WE0FMCYaR2so
	ssn5m5FYalKWeSHskcG8D8dyES0utQnA/XKtLwZwv7mJAPQ5QD/3DDGVfXm0ZsSP2xtnYzh2UNx
	zGhU8URghu8C0eliuWD/iyInl699kQ8yaRZD87T+ejr+xIXVgD2s5ZHDcOjyaL4h914hltx1Oxo
	P5RAZC66WbOoyfkohCsP9+9NJlh04MW4Ph0E3U+73+lXuvjd9UgSHwpuSUXl6UvbJtBARPRXnqi
	L7qud75WSICLI00ywOtkE240A8fuZcUNHE0HouJC7t00Lb8VaSrLnBjbtnJ9Zs0sBVfdo5M7C1r
	jtJtTyk9S9KBmKLPbeucC9oY/FXg0=
X-Received: by 2002:a05:651c:a16f:b0:3ab:1fc4:8eb6 with SMTP id
 38308e7fff4ca-3ae2b49f24emr231381fa.5.1794499780672; Thu, 12 Nov 2026
 08:09:40 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202608191340.98574fe2-lkp@intel.com> <4h7zrdfpu3ailx5ajkyqohmcfuxgrk3tn7i7n3dkp3ksy5xehk@xqg5j6pqzocv>
 <179361623876.3.16264907931792312619.redis-ibpb-report@gmail.com>
 <99b9d530-d962-4739-8f6e-83ee5c0e18a2@intel.com> <CANGjgdkmNTRUNebXcUVnmXfx=ofCTmioGw10jZsGfbShG5e1mA@mail.gmail.com>
In-Reply-To: <CANGjgdkmNTRUNebXcUVnmXfx=ofCTmioGw10jZsGfbShG5e1mA@mail.gmail.com>
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Fri, 13 Nov 2026 00:09:28 +0800
X-Gm-Features: AclHuK90H13AfC2kajknsWwbrMWddUrDNgqH8Fzf8YrLwLCTFOXpslvkhInORC8
Message-ID: <CANGjgdmcVPwq0+1ch6wO4_j4iaiyQEp1p90yYg=i5LMyNS9k9g@mail.gmail.com>
Subject: Re: [linus:master] [x86/bugs] a3af84b0fa: stress-ng.seccomp.ops_per_sec
 95.7% regression
To: Dave Hansen <dave.hansen@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dave, Pawan,

Following up on the Redis result, libMicro 0.4.3 [1] provides a smaller
reproducer: single-threaded loopback TCP. In an unmodified
parent / a3af84b0fa00 / parent comparison, native time/op increased
29.84% for 1 byte and 28.76% for 4 KiB. Each condition had nine
unprofiled runs per boot; the TCP baselines differed by less than 0.10%.
The pipe control was essentially unchanged.

To exclude kernel code changes, the following diagnostics used three
boots of the same unmodified parent, 96cce16e26dd, on the i7-12700KF
(microcode 0x3e). Using the per-CPU helpers attached to the original
report, the pre-test sequence was sham / protection trigger / sham.
All helpers exited before testing; the benchmark did not inherit their
speculation-control setting. The test cgroup was restricted to CPU2,
one P-core.

Inside that cgroup, the original 30-second command was:

  ./pipe -E -C 0 -D 30000 -B 10000 -L -S -W \
      -N pipe_tst1 -s 1 -x tcp -m st

Despite the executable name, -x tcp selects TCP. Each operation writes
then reads one byte; connection setup is outside the native timed loop.
The control uses -x pipe instead.

These are means of three separate counter runs per boot. Per-operation
values divide each run's totals by all completed TCP operations,
including executed batches excluded by libMicro's timing statistics.
CPU time and counters cover the whole test cgroup, including setup,
cleanup and wrapper overhead, not just the TCP loop; instructions
include user and kernel execution.

                                 Sham A       Trigger       Sham B
  Cgroup CPU time, us/TCP op     1.68762       2.19800      1.68571
  Cycles/op                     8233.34      10728.11      8225.14
  Instructions/op              20291.04      20243.49     20307.35
  Kernel near returns/op        442.537       442.379      442.556
  Kernel return miss rate         0.471%       13.111%       0.454%

Relative to the two sham means, CPU time/op increased 30.32%, while
instructions/op changed by -0.27%. Pipe CPU time/op changed by -0.18%.

Separate branch-stack samples showed mispredicted returns at
__do_softirq(), net_rx_action() and __dev_queue_xmit() after the trigger;
both sham boots sampled the same return source/target pairs as correctly
predicted. The samples identify locations; the 13.11% rate comes from
event counts, not sample proportions. This supports a return-prediction
cost, but does not explain all extra cycles or its persistence after
the helpers exit.

Would this smaller reproducer and these counters help investigate the
persistent effect?

Thanks,
Chengfeng

[1] https://github.com/gormanm/libMicro/tree/976d502afaa2d9b919564d7fa8a08fec286dfc89
