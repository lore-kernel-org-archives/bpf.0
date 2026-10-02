Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76B30C361;
	Fri,  2 Oct 2026 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901786; cv=none; b=pKOWtGOQFYjeXeYDBeH2E2egyNT881gjXGCbmbSRrUmoX5mw8hAvA683H51M4/3SbJbwni8LJVwr32nWZiiyH3YmJuE17/5QVCbh7Lf7Mi3NlgmbGcySgvSKI+BEOrwWG28AE7EadPU04qYA7+XEiBKEjYeRGVDTetImHX4vuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901786; c=relaxed/simple;
	bh=/QNNX47YmoGXXUIULdyH1gNMJoqJCmcuIN9E1oi8060=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GZCulK2gwSqmwQPYIWdn9RXSp2AHGiVSd+pIZRYLpTIFC/TfWZ7PZ7BvInQxAOM0BlQGre/EUXrod7GLhMdqWzeKIe+TLe3HgQ0SxjlcyPtA2s5bZHvE82OextHA4iEWMbdowLl/D+ccgIPaYfoBrJLHHUrPab3PComMdtPxom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCf9d9D4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCf9d9D4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E3C1F00898;
	Fri,  2 Oct 2026 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901784;
	bh=hnBdfhRWUTp42J1Mq5hPtFsjhXUP3jYQ+b3jlrb7XbI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bCf9d9D4c2K96+1CRpPbX9VmHCbVALgpZ3uyih0KGMi9Gp9DwTTlJ7fF+aIaRH4gT
	 4ESxQBxy2wTNr6rpze7QE08QBdEzrKkz5i5TBQDgdbhRKJ2IqTPmH+S3YpD2gcBXzT
	 +NreCdxelqAFf7yFOwVUH8CgoZkuudM72I8+FfxZntolgcAZ4gAEzxqUMj8UGLgcvv
	 Euy2+nrf+lT3Ae4xALLH3zYUkDiwpYQLEQUnNFJqQQ1TlfYa74OqiDfJ2x5EDuuC/6
	 nJK1eLDmB3c3ykXuxFm4zgE0lB+1CXdU8mrygC6o8LIOgrdZZ7fcG8GmtWKVIQPRRh
	 BJQxpkurWN1vQ==
Content-Type: multipart/mixed; boundary="===============7249801938157007284=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a792a20897c254b8e78e898517dfe7444610e82d65680b873f4524f9c480e1b4@mail.kernel.org>
In-Reply-To: <20261001152042.124445-15-gmonaco@redhat.com>
References: <20261001152042.124445-15-gmonaco@redhat.com>
Subject: Re: [PATCH v2 14/15] tools/rv: Add selftest for rv bpf monitors
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:43:03 +0000 (UTC)

--===============7249801938157007284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Add selftest for rv bpf monitors

TL;DR: Selftest issue: the two back-to-back tqueue runs in rv_mon.t may fail
with "already enabled" because the previous run's BPF maps aren't freed yet; a
sleep like the nohz tests use may be needed.

> diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv/tests/rv_mon.t
> --- a/tools/verification/rv/tests/rv_mon.t
> +++ b/tools/verification/rv/tests/rv_mon.t

[ ... ]

> @@ -92,4 +134,21 @@ check_if_exists "run per-cpu monitor tracing also self" \
>  	"$RV mon sco -t -s" "$RVDIR/monitors/sched/sco" \
>  	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
>
> +check_if_exists "run per-task BPF monitor with tracing" \
> +	"$RV mon tqueue -t" "$RVTOOL/bpf_monitors/tqueue.o" \
> +	"$header" "$trace_task_self" "\($header\|$trace_task\)"
> +
> +check_if_exists "run per-task BPF monitor tracing also self" \
> +	"$RV mon tqueue -t -s" "$RVTOOL/bpf_monitors/tqueue.o" \
> +	"$trace_task_self" "" "\($header\|$trace_task\)"
> +

Can this second tqueue run fail with "monitor tqueue (BPF) is already
enabled"?

Earlier in this patch the two consecutive nohz runs are separated by a
delay, because the previous run's maps are not necessarily cleaned up yet:

> +# Give some time for maps from previous run to be cleaned up
> +[ -n "$TEST_COUNT" ] && sleep 1

The two tqueue runs here are also back to back, with no delay between
"$RV mon tqueue -t" and "$RV mon tqueue -t -s".

bpf_read_enable() decides a monitor is already enabled by walking the map
IDs looking for an rv_mon_tqueue map.  After the first rv exits, that map
stays visible until the deferred frees finish:

  bpf_link_free()
    bpf_link_is_tracepoint()
      call_tracepoint_unregister_atomic()    <- SRCU grace period
    bpf_prog_put()
      bpf_prog_put_deferred()
        __bpf_prog_put_noref(prog, true)
          call_rcu()
            bpf_prog_free()
              schedule_work(bpf_prog_free_deferred)
                bpf_free_used_maps()
                  bpf_map_put()
                    bpf_map_free_id()

Until bpf_map_free_id() runs, bpf_map_get_fd_by_id() still succeeds.  If
the second rv reaches bpf_read_enable() in that window, it prints "bpf:
monitor tqueue (BPF) is already enabled" and exits with 1, while
check_if_exists expects 0.

tqueue is a tp_btf monitor, so this chain includes a tracepoint SRCU grace
period on top of what the fentry based nohz case has to wait for.  Would a
similar sleep between these two tqueue runs be needed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============7249801938157007284==--
