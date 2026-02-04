Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108C1BC08F
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164676; cv=pass; b=to56xdclQeDilj3lrfaTs1dhqMTNG06a46UMr/rxaPcV304RulXf6idFa6uW9hg75e1xITW++hP911yA4EoWSOFsqQ1bpi1dg89F4kRUz6BXcYDG6rdne34am0+e4O9I6XAvZXKMbT20c7TCglEE3LAs1m/ZDiSQjw5IcWeKkvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164676; c=relaxed/simple;
	bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxVbkVOwx6PjfEZFjIgsIncM3ESPfvJ51ehX+urxVWezn79p9bmDIFmKuPZF5nV3ShTGZ16JaswamGnSx/8VKFvWS+6qMLo5an8VmuvhRf9omqGi8Fo6Nc5R3xO8k9ajmL9oVCQOKSqsBSB+OMXsCt4iGQiWYbXQCABi5yC21AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR8iMIl3; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR8iMIl3"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8230c33f477so114057b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 16:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164674; cv=none;
        d=google.com; s=arc-20240605;
        b=jH0bCEFcUvAJc+6VmPHs8oQNdDFQcqXQ/78qMqo98yFd8E3Aok+oLdBu8DmnaeOr7G
         y6ZuUZRB835/yBeCtNXX1gqvBSo8/OjCi2Zs1ts2EHGeUsOY5TBOa8j4w0KIocy52u0e
         GFmD4zFaYsNylQoUy8TSdvt8esiNKCAP95QrRPkZdTm5Cg5UhFAiyx5yOjyxB37KlNMp
         BXjasF4/oU7gzBo/cHcaHdTJ3sl7lusW2PGAjhGRZIoTn5Az9k2q3VxcdMrX1VsYLPag
         Z/nhqeScYTdSDVOwiD6vqmAmHLxkaINRoiffmI0kL4019jek6WjkXcj0kSoVM5FY0wh9
         +o3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
        fh=yZb21trPVldJoc+rxdWW+gVE/X5bGxfsx2PVlbIbQKI=;
        b=Ygpxb+m4BA5cOgalGEBNp3H61I3Z0GNrZatAoD0aFv0lljQey/p1fPjMO6SCiYsEMF
         1G+XPHCDv5v/eNprAn1deTfzLX3qCfCq68OiAa0nv5hgXWhO7dPicW4PhSEn790oiGFu
         n9ybrvviJUuszaswOZOs/a9ehFow0+KQjxOJEos89iYhUMfErEy8uU/Qv2GySIzi9A9Y
         ZXvtDoDJOzGfKfQLwpq2B/uDzy/yfwMQ8NFgDlFVnVmmLmvBiykRdT25RfajF0MgZ+XQ
         0TVuy9cQN2vLjQvaLcFgyGSLCosbuX39iIheVMT9KbsO4caRCYsQkR68s4AexWd34yky
         uANg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770164674; x=1770769474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
        b=JR8iMIl3U0QLAJyKUVSI8SE78JZXBqO3ZwkNDMikk42XvdutMrUbtTuqHeQXCgEJpn
         Yh9qpWPDQcUwow4/yL3O1wz39crY9GYERS2Uq9SdPCpQLalcE0Ok6EsSqSE7Ix5NFI+U
         lKyzxrAtB+gvfedB7O/Ja8cYPcuHFY3PDXJ/P62ioXTNKwEqvzud2/bxnItdrP5iLQnN
         fMYa7bSuWAt2lS+HbwrTd8313SK7UUuIlFSaAwOHYNDbzyMFf69wRnJG5s+UUzDqXrrJ
         02zNzivvAYjujv3X5+8GpGVMKXcKc3IWGnsY23f+FQapZniRBigGo0KfaXF28CsBcwbZ
         FCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770164674; x=1770769474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
        b=JmlIMHzkwViXYjzogqwZ+n7jCsCQ9MTCjVoj67C1pqjwZjapq70a6kAoDgQxwUny6t
         wYP3RkhmzMVsaU47O8IViIgJHySkpY0bXhL0uTAmgf9KN1IurIzinX2lWOGu37N5ZAcl
         alub/fd5X7dk9TKYB+PxcCwxCDDQJ2tO0xizCwdTv4wxhQAfdB5R3JQDXWrWG+rBwI4T
         +L+6zD8WSARKplPydWgYLwvvCNB3ple6dPp71L4C/3+kew831d9KJds0m8mBLvnzG3tN
         ePOAHUYy0sOqzzbrHLpd/akshNGhRjcOumpZd0G+OGVYeF7PHIn7+enbB/22N7GMrAFH
         s8gg==
X-Forwarded-Encrypted: i=1; AJvYcCVbySwNkBRXAxunmANLiy0KqSU40zwICbU+67xXiRJbWQdOlsQ5yEg34segCjbn59Tx2vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYq/qBWTSUputIUE63tKKthXKtUp2sK2B9JgFZfJASdKdqBZ9
	vc1XA+VnEE1Gd0aKAKWe0gBxDU4qu8fMa1QF0ellgMJLGoxZBJ3bT/HH0uY7nJnCLdoPVg/rygn
	/qo2x1FDRXcLSs6NLnlL3jWfZJ1r8DD4=
X-Gm-Gg: AZuq6aJ3dEETZ8dHfX14w+n0Tcv56B6r1qX/m+o5hQ1fXjMfKze0M6qkI/cp0mUSUzR
	O/NCePBFnv0DPawadLU+hO73PxPIyjUTDPTyVd0m/Ug809o0LXOWmvWwvX5M8AB+9l7vjwjIQ8S
	zeT3xfCqXGaxLIvokPtmfmXiJd2DoLxFKd96KlE3gpD2cqhd/vXktdeqeagPknG/Y1eMFsPOkwi
	jgYBqzDo+/dM2fCjmcZ64MAVfst5cxdFqmb2/MTA13rDWXSfPSxd8itAU4ohkaw3bCab6qLrW4f
	QO9rSMsJJ7g=
X-Received: by 2002:a17:90b:3f45:b0:33b:dec9:d9aa with SMTP id
 98e67ed59e1d1-354871e45d1mr755074a91.25.1770164674418; Tue, 03 Feb 2026
 16:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
 <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com>
 <20260130113150.GB166857@noisy.programming.kicks-ass.net> <CAEf4BzZNOqxhkjuePzeG=ivqBSHXnWzPLPPHJdoC91c+u-WjAg@mail.gmail.com>
 <20260202195943.GI1282955@noisy.programming.kicks-ass.net>
In-Reply-To: <20260202195943.GI1282955@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 16:24:22 -0800
X-Gm-Features: AZwV_QjfrlFp12nEWIHj1VnfqarPHZheZpDK4zQAPFm6dulsBZsc44JaGkW4kNM
Message-ID: <CAEf4BzbTLqzcrbyfLmhB7b9XZHLPno+YfZtcw12ZbcwwaAP6yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jan 30, 2026 at 12:04:45PM -0800, Andrii Nakryiko wrote:
>
> > > Also, there appears to be no buildid caching what so ever, surely tha=
t
> > > would help some.
> >
> > Jiri Olsa proposed caching build id per file or per inode some time
> > back, there was vehement opposition to it. And doing some locked
> > global resizable hash that might need to be used from NMI sounds
> > horrible, tbh. So we have what we have today.
>
> See kernel/module/tree_lookup.c and include/linux/rbtree_latch.h :-)

Ah, neat idea. Each node is really two parallel nodes for each of the
latched copies. TIL, good to know and thanks!
