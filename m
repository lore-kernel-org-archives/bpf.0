Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578D395D8C
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245669; cv=pass; b=oS/3VtiqY6tFYcBtgbjUjagkmgPokfo0yErf/bghTq2fGhyY4SmbwR7sDarJ9mOD3qajZhwr1cTxmzfsQev4D/f4stXC9iOLsR1JQ3wKc6QVQPlV6UiP1h69IJ5fzI49Vr23+hKwaNTmS/CRC2lOEUmLjtprvD+A4RFkWXhgln8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245669; c=relaxed/simple;
	bh=oxIRW379dEOiR4sxsQeH5UaQGg3tBVrMKYJi2SksZR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJrLjfDDucItlyn+uhNLso9FMbrU90Yuqe2rtfQRKYeFOwq/rK/nmfGQRxqneNs59h9m9hZZ32XcEzO8KJ3OJZyFrfsk/c2jeC+KAiDnSVF4l0LMUbU0vnyFev9nnfTV6v7+h+/hn6QnaMciLud8sG+YJIleDPcxZwCHng0KbMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVWM9myx; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVWM9myx"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139a5f4ca15so337825c88.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245667; cv=none;
        d=google.com; s=arc-20240605;
        b=h8QNanZcV2qe75wjoaymzMUtBRSn30EpKgsJgokFAVM9BdohAmJly2cofRWuE5dq0l
         cEJSM/qsvsFFKJwBQIz368GT+oSDNxDCjAY5bXYBWRJLxWnPxDNHTtsOgx1G9cfr1c3p
         u5Wrr7y40ILuKGsmJ/YpLqdyMkDEOA3UW5xSTyZh5WAPPp2v7D/cwX0W6ldI/MyUCxkJ
         6gHUQSjZaET1edDbzVVlYOGI1bTCfmTATosszmoNb6QCDzCoRF0ngqVeOHxmcCHeO7wI
         sN8xiolot3xw6OFP0iRgaX+foc4s8uZ2UoZKl7cykmNBtbFDWSVA/s0iRWmN5VsoyrQ8
         5Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l2wFhTrR9bWt+SnTkWykoVxrAti5Br92yzIc8/PvEwY=;
        fh=eHpjKHrsPBLFAo6qmWotK/iSi5qSGhcL42Rz33h0Ek8=;
        b=jtHnDsDsOp6izT03fOWnnRVoL+nqxDa9QuBpC2rYpa2Lnk96j+UN3nOSp19TM3wSlI
         3142IvWhMQ8MlUS4+vPGFBqUx5J3iHYr+jD3y+dVJF2q3eHjipiIBXNa9zuGEb7vGBjR
         IP4ITFVqP6va58x3uGFan+P9cNCPlX1O/P5ksrhatDgTEEPZe1YbpjkuWc1Fgcy0IOiD
         S3oHCL4Sbti2YTuLMgtTVEPPOZY0qj1x92Jqv7FTch5hgA7og4o1NvJ77esEZutHjP5b
         0tOc4y7aqxY3wHLUUGGO4pEjZMxstn32edkpj9FNwJIsd6cKXzKjCmy4PBws76eJzIwe
         Wisg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782245667; x=1782850467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2wFhTrR9bWt+SnTkWykoVxrAti5Br92yzIc8/PvEwY=;
        b=bVWM9myxI3f/zO5/JfvPqp96aDNXykOfRWPcF6lrBZDyYiZOJztaZdKgrlVdPyTTTE
         1/VXSpKQrDnwTvyYfiSvhwxTp7i9TGzsySXVyT5KEo9bvMZbSgh037iOV8jjXx/q29j9
         tgGMzxM2Nis7Sdw+mMVTmyXqfH9pN4Py7mhV8pFevIWWCFpoROPTvsoAuKf8ezwX8HyW
         CytfdwQPlMbQT/FyLlzkWhUCAwislYAypQwrDGbxxlL3Zo7LBQAaDewfvqnPmsJhQQg2
         alersG23sb7WCjJeBZacwUmqQwLkF8M59lRax9/3i06WCRTviZ+6cwuNxsY/d8HNWEPI
         vvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245667; x=1782850467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2wFhTrR9bWt+SnTkWykoVxrAti5Br92yzIc8/PvEwY=;
        b=jcQ2nCgnO7ZdIhVTytKgbkmTVdHUPVTkzmUHeMCpvCDAVUD8PxDVEer+UUT+lhgFNY
         LGVmviLCgLe/UjsMHYOEjssNi2fKj7S1W2QXlx1LU5MB3XWV8U+UUNdJ+dXp7Md+RE45
         hLuiB/h15VlYJBbwTU1Zl3l/nMKTjbTzwoVUjQXuSjvG1fXz8UaFpnwU5OehOMQqreGC
         e85GNO9ZwIzIwLr/TTyz3t1bi+ZboWzU+ldMS2+/mxgZLJ7jma5tLXt9MDTfaM+TzTBS
         vYu6zdGXNln0nHirpsnMUljt2iYmnuxL+zfbaS4+yu8VcGldL/Yi4ZYte6F/DcYmQqxt
         SA8w==
X-Gm-Message-State: AOJu0YyUNaetieeMR52jIOnb0clC/AZznecpf39SBCY98vUZxWqcypdT
	kP4+FMCDxKV1Ivxmv8iXoL5tw2Rr/6i7fB2eXFDcBVzMkVdC1DFYZOZjq3BuhDmfyysaGgBgT4q
	buau27MSqHuVwCqf42lltOHByjYzhu1QUWJbHaAsk
X-Gm-Gg: AfdE7cknLCKXencUeKLBDWuxs0vvFktmiqWS7zuN0jsrboFDWG5sQmXytv051x9cKhz
	GTzfFBHUpQHeIkcVTAPEaohFBWPJqvtG1j6s/blr4FYI64fgaDRFa3qyfLzQLjrWUAVwwJ157qY
	nzwPAk7LTSLJIqyiUXTCIXI3kZJm0Rb1RPpc7hAu4sPuew1xWD6EpisQU3tPJ//fCRXZ0MU+raP
	YCkU7v2c8EyBdHIpWdaOtKNdDdPXCug8vPueKWreAUsAW9bTvANXavDn5Pp7aHow095jsxU4eWL
	SaWOHjbXH/GmDMGIssDXGm96nM+Xr5F3E+SRjX1w1iWCqkWQmJgZXZdcoXQ7sCOUKZ0bP6cAFj+
	adO77RGlZR1CcoeapQdwVO/fmw2kWipIG0rjPg7Y=
X-Received: by 2002:a05:7022:ef12:b0:137:fad9:3a30 with SMTP id
 a92af1059eb24-139d0c89276mr178539c88.19.1782245666128; Tue, 23 Jun 2026
 13:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <87h5mtyq72.fsf@cloudflare.com>
In-Reply-To: <87h5mtyq72.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 13:14:15 -0700
X-Gm-Features: AVVi8Cd4JbQ-SnwWjMiK8HrPCjCXPhIvsiWwDPufvBNg1_Ylt_ZyYN2I6rh6C1g
Message-ID: <CAAVpQUAs2akj4ZPMi+ofGV5fVwUr3L0hGJ7+bF_CPe-oVwOpZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 1:09=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 12:31 PM -07, Kuniyuki Iwashima wrote:
> > On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudfla=
re.com> wrote:
> >> Okay, will put the whole file behind hidden config option like so:
> >>
> >> --- a/net/unix/Kconfig
> >> +++ b/net/unix/Kconfig
> >> @@ -30,3 +30,8 @@ config UNIX_DIAG
> >>         help
> >>           Support for UNIX socket monitoring interface used by the ss =
tool.
> >>           If unsure, say Y.
> >> +
> >> +config UNIX_BPF
> >
> > Maybe UNIX_BPF_SOCKMAP or something.
> > bpf_iter is supported without this config.
>
> Not sure what you have in mind re bpf_iter. Can you share more?

I meant UNIX_BPF sounds like it covers bpf iterator for AF_UNIX too.
