Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793921752;
	b=jI/YH3z/B5oSqamGsfkSJ0XSzd6mWA/R9+QJbFE7lsRFZX5v3zNniAPPwtXDUtjawOPX
	 coC7gGLsZy/IAFBErpVuylTTiTawfYNk/avc2m48WMO/DKdewtJsLJmp5VrD0YvGH0SLk
	 s4A9NfqJTPYnfCPhKgX+T1GZ9c4oMzJNK1nWzkQiWaqX3SjHTy/afLobnmvqn3yfGIDeM
	 BAWWSgpJItLgoN5HPBVEsJ0msw1tcfLhg2KnlzDtFj78j/154fHznu9HuPYODFfhzzq9h
	 1d9x1D+PlwNJ2chF9sSLIyKVlVetOcCnzx/rXNsWWJ9DKUUyOSPQATrc2kMO8jFOjJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=GCw0Dw3/6zz6nZRQ9tZkZQrpsY84tJiBfsLr+6sG1As=;
	b=dqHode+lPM2KO+CngZasgEfhm/gSc6ggWVPOdsyq5spihtnxs02/nxNaU1zC8ymAZ+rz
	 MQI+7gmYXfUBDqrWDkTps8dJNBtKtJUak4PmizAq3///ZGclc3GcM+8EVh/k5GLEkl5iz
	 W1Jl6S7U0FKz/ST33qK3n11z9Xmuc8y7nooDQfVLKKLeoAAPmycfeWXMQi9G3GratjjNr
	 bYwZwFyzx+43fd1bgkvGtGQMxZ5qRs6O7Cc9Wjc/EByPHa5KTZ0ftjrsNkrRL3MIPwSLC
	 bM8BaHsaTIlOJM0LyKc+kAy/3zmx0+XMeTSn+npJG0wEzOj1J/zxlqZoJkL1w47OjQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=KsafWJik;
	arc=fail smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E9606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 23:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=KsafWJik
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae1a9e187aso10128a91.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 15:35:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793921752; cv=none;
        d=google.com; s=arc-20260327;
        b=Mwv9RgaPc9WLJ/9UC0zdvLYLU1ywbhcb1WiJ3JimyLaf3lptPQ0zLimyoEldbyjP2v
         rIT97OT3dyTaDGPfQqqheciJiskhfEMtBOFSFYqeqbMSa3kTYeJ2YVxdPCniNSUQYC4h
         c/mqBYlsMjXB5XvS2DSSma6vayrZQRmFLRWZYfPhAQhNu0BPaE/Jsb8jnAypMpUU1JTw
         jwwYc2J5dXvHlqnh9c3S5rbZ3CdQkbeU/CTJ3IL8cKvyi2+WhCyDHnc0gV8Wr2GjrRuq
         XX50x5j+4ryWQoe4lXcqJx44xPti3NeIiNATGKt1jA+t3KQPcKzCmz2KSO3/TiokXwkn
         JdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GCw0Dw3/6zz6nZRQ9tZkZQrpsY84tJiBfsLr+6sG1As=;
        fh=66s0rv7lJiGZntkgqUyGWUc1a29SUcoztyyLsy1hYcA=;
        b=XGGjm9crLBhdpeIbHIO0NDZuKBwRO/ZVVQ05CWkzcRBpav/jxAr99Ea20zY1/5TeiP
         YNm7vsTLp7HiezmLgSm4x04dfRdPoUa1vAWr+3bg7mLIZnQ5VWtepK9dFBcYRN7P14Sz
         4BJGJEJNJqgs8qGXGiGZrSiO8wLBQhxJJzDAp/Rh7+iJJ37XePIMToN0cCuLYGRkDqMB
         PpQhww3EZa6pJjgAR48aIcODBSuJP50ZCCCKixdXF0FZsriDMjlF0FaY4XQMhXAY15GO
         sHPxPaOMyo4npSbWks0cX4/C8c65JcQyjeb8dWRLPVUPhcGj5I/1pYmdRxQi7/XJ9asF
         CfSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1793921752; x=1794526552; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCw0Dw3/6zz6nZRQ9tZkZQrpsY84tJiBfsLr+6sG1As=;
        b=KsafWJikuo8FptLtf1RAxBqfXSGGJ/r8dS8Az671M1Xt4RUwVxO7wVepvIlQnOFBBf
         /MzkoiTn08xLX5LP+ahx8pNdH/6ukulK1QEWgZPxxWAEft9c9IsiuX+R0D0I4uOLWlvN
         h6pHrdaWzf4HfMYbaqATPgSoUqq3x78g0hsNakpCOrJKeWKkirPTnilEf/VFX37U2BZr
         89ylElyZXLuhv8PJRcTSqT2qOarnFkl+Z7Efa0cGxSAtBsmcQDPO5MCpc6I7B3NkdWmc
         LN/wvlS4dg9PvAVF4tguXMFlLKQb7alfujZj1CKStebBAsAb55nxUXfk5nOT3kw9FSZM
         ItDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793921752; x=1794526552;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GCw0Dw3/6zz6nZRQ9tZkZQrpsY84tJiBfsLr+6sG1As=;
        b=FC580gMuglXryEsdKrP68LbgCSRK65ImnbkXxFxage92ikcuChFy3mIdN305h32uXW
         pO2X6YR9glorEPUdam6BYR8tNPBoh+MS/4N8Hg7kOT6U2qoPcpPEyUlZV141DCBq0gt2
         LYh9J1x0dzJhRHKqOLI+Pqkf6YVIWeGpK3gfuOFdgnBWVtTt4TWCbyZHe/rDMvfA9mFI
         oH+VxEhCQlXZ34Hq4l5qdy4/V8tmaJVTfO/nsG+cDVmJXnOk4DlbrOA7BO2gP5flsf/e
         CSn4yxWm398DuZSLtt2vGLI95/3zqbDltUI5fHQ8DUz4FBonxiSipEJnFDFGtzdpOzTG
         C6aw==
X-Forwarded-Encrypted: i=1; AKwUvByI4TxD3HoxZbasvpAdrhtOGJcyK6B7c9LerDlKobbXFBFl+DZPAVxVR8fpeOLzQJK4psA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Hg8J2/gzvY+fmHjkiFzZx9dzdVtbI6VCemw1WaPgWRMKIVNl/
	7R1LtW5ZiZgWCI/vj7QfJM5ZP3AE+5cmubcj9pq/YPxUliXoj2o69dWVo7lvUXGmRvY0ori90bf
	FiRXKt4X8D3cG1CnCtpWJRRUtybj0eGneJeZQKipxeQ==
X-Gm-Gg: AYBFou2eA4XrLGS+y5Wg8i1Bi6LtjG5ffyitXk0qcYKQb2gGlKeiSDmYeaxLEAj6Ouz
	cN2bem72QcXAd6xhLZgOU1B4KUWNgTiHBUMgI1MdIZbdaflJZFghpZDRj7g2UbJ2v8P6LXgNTJU
	o5x6qRZflWb8aHJ2osoQrhmnYFWrKYIY4SagBMytAw9n6mG5QeK407Mk3MbTUe0I18dsbwIVppJ
	s0m8oeYdEzfavZAJ6Gh+grXAxS5mecxW5z2L4QcaTfGqqd6Cx4DEUknP4rG0DzULP5HsO8FyWC4
	jWfmHAzamhGG7klqUuhKDIcPRZFeZ8Us8AFZkslDVODszQBfVTQYpt/ZYNEU8uVUn1bGP2WwxLE
	RFbmpwdwCj99Dmhp9ejHWJDIS5fbaYYidOQ==
X-Received: by 2002:a17:90a:d883:b0:3ac:9e5e:d1a5 with SMTP id
 98e67ed59e1d1-3b0db70872bmr1109408a91.6.1793921751683; Thu, 05 Nov 2026
 15:35:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
 <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com> <CAPnbwjpQBR-KHwOMG2bo1uhdp22ZW_O5sUj3=vjazVu=Rdnb7A@mail.gmail.com>
 <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com>
In-Reply-To: <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Fri, 6 Nov 2026 01:35:55 +0200
X-Gm-Features: AclHuK89NvSJapqCJ93P1wxW7lFPP0JUgKVanIyU8NMBiBOqz8MX0h4pCCAe_No
Message-ID: <CAPnbwjrX-ywbcgNQSZKE2jiggEOSVCRVw9OLfaksihiVSCoqvw@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: JP Kobryn <jp.kobryn@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu Nov 5, 2026 at 5:14 AM UTC, Alexei Starovoitov wrote:
   > Also try NO_HRTICK in /sys/kernel/debug/sched/features.
   > That may be decent workaround for now.

   The 7.0 numbers I posted were already with NO_HRTICK, and either way
   our agent runs on customer machines, so changing scheduler settings
   there isn't an option for us.

   > hmm. you really cannot tolerate that small drop? it's tracing at the end.

   For security monitoring each skip is an event we never see, and the one
   we miss can be exactly the one that shows an attack. For stateful
   protocol parsing, one skipped sendmsg/recvmsg can desync the parser for
   the rest of that connection.

   > let's try to think how per-task counter would work.
   > I'm guessing 128 connections is 128 threads servicing them,
   > so 200 cpus will be hammering the same per-task counter which will
   > cause real perf loss.
   > Gotta do better than per-task.
   > Also it needs to be per-task + per-prog. How will it look like?

   On Thu, Nov 05, 2026 at 01:26 PM Peter Zijlstra wrote:
   > I would strongly prefer all BPF programs that attach to known
   > preemptible sites to use a per-task recursion counter or something of
   > that sort.

   This is what I have in mind for v2:

   - Every trampoline and raw_tp run already has a run ctx on the running
     task's stack. Add the prog pointer to it, and link the task's active
     run ctxs through one new pointer in task_struct (other prog types
     don't touch it), so each task has a short list of the progs it is
     currently inside.
   - On entry, walk only the current task's list. If the prog is already
     there, it's real recursion (the same task, or an irq/nmi on top of it,
     since current doesn't change there): skip it, as today. Otherwise push
     the entry, run the prog, and pop it on exit.
   - A preempted task's entry stays on its own list, so another task on
     the same cpu is no longer blocked by it.
   - Cost: the list is empty unless the task is genuinely nested, so the
     check is one load and one predictable branch, with no atomics and
     nothing shared between tasks or cpus. The walk is capped (e.g. 8),
     which also bounds nesting depth. It also works across sleep for
     sleepable progs.

   To keep the per-cpu guarantee for existing progs:
   - Make it opt-in: a prog load flag for fentry/fexit and raw_tp progs
     (like BPF_F_SLEEPABLE) saying the prog may run concurrently on one
     cpu, and that it doesn't rely on per-cpu exclusivity for its own data
     (per-cpu scratch buffers etc.).
   - Flagged progs get no private stack. The verifier could also enforce
     parts of the per-cpu promise if you prefer.
   - Unflagged progs keep today's prog->active check, so existing progs
     see no change.

   What do you think?

   Mike
