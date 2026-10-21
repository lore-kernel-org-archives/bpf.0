Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540932;
	b=5fL0Q6XtMs8BMP6EiHAqZEicsD949O36OJvBsw1Q4znZU6N/6MBgRjxqYk5S9D/KHeLD
	 W3wed+EluMJbaVxE2hvVx+fkJ9AW5ui+ih89G5OaNrwBJ7bYUddQxPE7B3vbmiFr1id8f
	 Ayft+l56vHBMegzrvzQLCZnV2Sfcpap3lCmtIVKu8XDH9h8gFc/TzIcALrGQ5ORAxaFGH
	 HJjWk3Ik6wmrkVEM242i8CdBMqGTMhH1jWttPGPzKRbZgjespyKlhJ8gRzg161eV1j1wG
	 kk2NrjtSdI4E9TlAKlMKpAFFF6Cih/zaihEIM4YDlYhn393E7wxYMG5SlKDdgSV4ubw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0Sjn0SBxkFVS93olNVmryUIhxh3i95NSdeHhlcsU76k=;
	b=Y2B8MofqumDvKeqtQUC/wrVkrUvpJ8zB5Vwb64UUZBWex3ONb8ykdDHYfCFvm6NZcgTL
	 WAVWQLBNKUECccf/IxMm/RWH2UBZ30bqOUh8z5n2/seNc2DLHUp+B/7L3bypT7t41UHlF
	 jc51W0uj+XnFsh49+COyMGq4GUjWjTwLllF7xjsH5K0FKwiJ8QGsFL7DisdcEL6NSf+k/
	 R/cY4/xNWIQWX9TORdURj4W0pWYb3REwP2oYec2MKcEQ2JfXiDbPHRSXrFX1r1geI3rUt
	 mWZyAE6HLLCEn5x6BrV41T0rwXB72Hp6nXxtBU/9EPpLEoBo2JhswDarfWQw0vLchDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jx1UBEEX;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDC606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DDC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jx1UBEEX
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e831e86ebfso675255ad.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540931; x=1793145731; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Sjn0SBxkFVS93olNVmryUIhxh3i95NSdeHhlcsU76k=;
        b=Jx1UBEEXHx6Oxwwq3C+Ozk6aZBesuBt1JF9Acfs7Sqc85fhjRuuTPa0DI14ykGtP7u
         z6y7XjtyC65SxC60AjvrqvzpdzMLLSaNqp4cHP5cL1Z6kw/nS6JL4a3l7fhQYoMoPLuv
         k+h3yLDgjr3marUDfgTWNRXQOIwqnl3hOe19U5txNfWf9uKMsZld9oZmEmSgghSSDOkd
         k5hbdrtzZXwPFjNzjrHq+RdinmezTPRybN3V8LJGDMbuBo65rU9mbMlBz9zO53E6sI8x
         czAiQI1UnJzeshMQ91MrXryaPdKetz1ANCjYbdq40Wtl1PPtrixVbjyrn0hmOAiLbvAp
         krKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540931; x=1793145731;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Sjn0SBxkFVS93olNVmryUIhxh3i95NSdeHhlcsU76k=;
        b=bH9BAnGFzN5dyj9QcQ8UR10Ggq7ll/Y6k4VFpIUIFqq0xkzqusoVETxJk/s9jNxSNh
         KQtBfBolXOz0noKOQmSSQRxrzdn6rGEyiIbwrOlW4f/FprL4y3iPMFiSbLAYx50BUVCK
         dD2y5ZpSkU04u/pozdce94lwkdZRjDUcicRA3fTJJH+zPvE0EOmmieByTy2pUt4MdZ6E
         vNejV2Y4uNuFiKiH4Cmg7mpL5RcvgKRDvVPQzyPmYWGhBhhS2h6+WYsdwtW31xx4lj5t
         b9sqaJ0kIqK4BAfNC95LO9UN5n3EnStCQPf03BfRy0OlW7bxtyieDNcCyhYHJ1zMSuG5
         Nizg==
X-Gm-Message-State: AFq9FYLRDjJsxUOvKZM755CCiXSuznCNws+zytnZR/tPVJEWs6+ElxYV
	FOxhL+9ouMzb5SfBPNMhoXFq0u9cG0kj8+7JSfnvGmpj4S3UqBM6VoMo
X-Gm-Gg: AYBFou2oy7JUZjH8V3C7gmlZcMM9m5FDGr+ugdaILP57/YblraTH5nozqfwTGQFclAu
	av5Ih5NL70JsevKKVCokvBMP+w6/O3XuICjjss+Easyw8PVFdyMaMctGNu+va/wJj0M5OgoUj75
	aq9GkArxazALwJ73JltXQMqlMV2jPnocrsJ0xNW5rSjhzw9whFiqkQjwkL8IFBqbWBQx2IO5BLk
	0CTmXgH08hl1HdBA5vsTvD2JIcHyiGr/y2FyKAtj4hTkatHi57sBK01roTnNy74YTFMB2dH5SVF
	bb/dkfVsEzZJXtlfiPluyO4qXxe4eeT8RIMXTEMICqvQBITB59DRYNUvXXzHY87mClOmRuk8uFd
	wHFQbkxLkhSlavJgSfK0kGWSEqzXq5Zmxr/RRAT99sOE0FF8tjtHaTnq43TpIjRcoQWfi5TAu7Q
	zYySpnGwI1Qtlrlw7Tn0dfk5FR7XsF53WyLOwYmsmgV+fjyuggqqqceCKuV/cxbAIuoBIqx2ECa
	MYr4uFdxa4zmSKmZnjZta4FtimaJzx9thamzovDKZiGFXwLRKcNKCAvv7VIdIVZtGYEym5eyP7D
	NTJrTMJxn2G7OobHVn6McbhP4j8wRgBc8lTaxWyuyEcls+6ZWHgoY08+7LnlQw==
X-Received: by 2002:a17:90b:164b:b0:3a4:6e84:e7f6 with SMTP id 98e67ed59e1d1-3ad86c2e5e0mr406559a91.5.1792540931285;
        Tue, 20 Oct 2026 17:02:11 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802957d3sm1538729a91.8.2026.10.20.17.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:02:06 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:02:04 +0000
Message-Id: <DMA2Q4DGMWPS.33II3DPA4RW0L@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Wait until the .data map of
 test_mmap is freed
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <20261009-selftests-bpf-mmap-wait-map-free-v1-1-96d066daea2d@gmail.com>
References: <20261009-selftests-bpf-mmap-wait-map-free-v1-1-96d066daea2d@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 06:49 PM Qiliang Yuan <odys.yuan@gmail.com> wrote:
> The map goes away only when the program that uses it is freed, which
> happens in a work item after an RCU grace period. With other tests
> running in parallel, that can take longer than the polling, and the
> test still gets an FD for the map ID.

Pls include the output of the failed run, the number of workers
and whether it's a debug kernel.
It's not one GP. sys_enter is a faultable tracepoint.
bpf_link_free() does call_rcu_tasks_trace() and only then
bpf_link_dealloc() drops the prog.
Then call_rcu() in __bpf_prog_put_noref() and then the work.
Also test_mmap has no .data map. It's data_map.

> Poll until the map ID is gone. The watchdog of test_progs kills the
> test if the map is never freed.

It doesn't.
watchdog_timer_func() does pthread_kill(SIGSEGV) once.
The timer is not re-armed after that.
crash_handler() prints the backtrace and returns.
Nothing faulted, so the thread goes back to where it was.
That helps when a test is stuck in a syscall. It gets EINTR.
Here usleep() returns and the loop keeps going.
If the kernel leaks the map the test spins forever instead of
failing with get_map_by_id_after.

> -	for (i = 0; i < 10000; i++) {
> +	while (true) {

The get_map_by_id_after check below is dead code after this change.
Keep the loop bounded.
See wait_for_map_free() in tramp_prog_detach.c. It waits up to 10 sec.

pw-bot: cr
