Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F42D24B7
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770708885; cv=none; b=GluKplQySLbCF13/NslvzRD1dweUxlR6J2f5/lKz6j4Ei2FIgZu6+englW/hZEKTVLOBmXnsT32XdsGKoJl44x0+7l2Ghe+7sSwn38J68gTfnk/fjILLjj3LckwtJYG7VQpgm4GoKm6ze8VC9PsHCRLnahbK/wndbNhGWykUQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770708885; c=relaxed/simple;
	bh=v2sooIf1FRIe+UPKm0Sq55cOkPDEkv5oMREqEcvOBRE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p9mWL8kTzVc8X33yAEpRb3oGOAza+IrKYanNcZ7Swe0166epRaFpy/XpAOkkE0/MKTFCFbYVsYZWzpeByVXgYuyM9k4L2f1uMk5M0BWe1bG4PU5bEiOcVxpbw6nmMc6ww8/wByeFdtwe27mtMH72JYgkn/3oH/lK9JtVCmm9EGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BirCzFmw; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BirCzFmw"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48069a48629so48706205e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 23:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770708882; x=1771313682; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQVhQ8ys1hpAEnz+G1vvU+PeMvaQjd06HAYk4IDSll4=;
        b=BirCzFmwvVgjP3SEU+VjBujjgCY+vDIMMWBbsWL9Zm0dtCxap/bgvY5NNX9qxlsKTN
         45sJOGd3BP5+MFPOatDlYMg6ojJC34QULgx1Ysz0sSjoO3/kn6LotgU55sF79CXy4RH2
         Kb6F/SMotHu79+hn3lsDhT4QGvh3A3Ak9tnSbhWb9rmbeP2E1oAIlSqfCbcVn37hB+M4
         m+X7VXI41Q/DcrExFRWaZXbnBXHzak+5XhlNWNRF1IZwj7rC/RwEhsh+uy/gHS8NL7TW
         g5M6n2juoXuCtx2HxD0XT1rOk/lpvM9Y0pIfrutkRb6o+57T6EUyLphKSG6v/Jcd30aR
         GFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770708882; x=1771313682;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQVhQ8ys1hpAEnz+G1vvU+PeMvaQjd06HAYk4IDSll4=;
        b=Lkr7EEZVkj9BA2npckmH6nq4sEj2g2y8XEEUtRPzzg9L62VUBKcB+oVV4Uk0JHVwsh
         ScraEKDGHWDF9JpFLPmc5o4BYaxmmitUmY2gEfwJ6YzrGIVppsQ0R5bTVaT/nWRHLhMy
         o1y/dZPdicqotjCwEe+ys//AppTnOs6UhGF88mOubcMO3vMLTT80Co9U4HxiXSBHtqcw
         iSKPBsETv+tyAedsSXTVWQfFh9KgVlT2YpYu6D/rMpRAhrkeDu4a/KVcUp5GOOwdf1LP
         ba7z1C8uVS6PRZjRNqQkQDYfSdxUaQWnzBXjBXOU2FgP3BrvSpu6WH0qlWyYQH6LNitd
         dvgg==
X-Gm-Message-State: AOJu0YzD/kWPVtspVdDjA2/d2BK1CBVZSdE9LhMxDPpFYBVIYSb8PSxS
	5sgvnU4HwWOA75DPf/T0Q1zM6jA+poDnfee+F35HPXK0DfY2WaFYWts+uijTaKid2bRBfheFGva
	yYB9hYZc=
X-Gm-Gg: AZuq6aI7FTbAoHnUaNjgUpWIFlKQM1GvaUy0HmO0mZpLPqTld97rmDwfIBj4KkJt2J7
	6a4cT6jKNzbndxvRtYS7SIqG7xu87b+Q1CBfeOoQXI+IAvyGCYS2eBHwgoEgLUu6q67xRsCD/bm
	C62Vm1ubrEtBLRHwnUwgP3lds/WPO1RwIp7NsHwTTRllZ0Xv+YTa6oImjpju+kQ6rqfHM6wqGWe
	QgwU0aRT28HWI/eOFmK94p+PqGIswhdEclcIE2PfMlnExSGcSPDi8/hKuIR7aczeFKjM0KyUoSo
	XwXI+iayAn4xgamL78jjMbTu2qQe0HsvOk7Co5TP4VlzPmdseQMmvSVVTrWVN+Lz4vu+ympEYzi
	zM1ZnQoTI6Z7i384CXoTeaaXq07xC806/7e5uDmQYONRCM1lWJ7kvybWr2fbunMcySld4oft4ZS
	ANyRBmdJqewgWaJJ7ON4k=
X-Received: by 2002:a05:600c:3b1e:b0:483:3380:ca0c with SMTP id 5b1f17b1804b1-4835083456cmr15627685e9.35.1770708882231;
        Mon, 09 Feb 2026 23:34:42 -0800 (PST)
Received: from u94a ([2401:e180:88b2:82eb:a79e:a730:cdd8:3572])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521eb87fsm133651585ad.71.2026.02.09.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 23:34:41 -0800 (PST)
Date: Tue, 10 Feb 2026 15:34:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Mainline BPF selftests failure due to rcu_tasks_trace and
 do_filp_open changes
Message-ID: <djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Testing with Linus' tree (4adc13ed7c28), BPF selftests in failing in the
following cases across test_progs{,-no_alu32,-cpuv4}:

1. map_kptr: failed to create kprobe 'rcu_tasks_trace_postgp+0x0'

   rcu_tasks_trace_postgp() no longer exists with commit c27cea4416a3
   ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")[2]

2. test_profiler: failed to create kretprobe 'do_filp_open+0x0'

   renamed to do_file_open() in commit 541003b576c3 ("rename
   do_filp_open() to do_file_open()")[3]

Not familiar with when fix for these are usually done/sent. I suppose
after 7.0-rc1?

1: https://github.com/shunghsiyu/libbpf/actions/runs/21850240572/job/63055018509
2: https://lore.kernel.org/all/b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop/
3: https://lore.kernel.org/all/20260114043310.3885463-32-viro@zeniv.linux.org.uk/
