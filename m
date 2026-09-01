Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6649E5C0;
	Tue,  1 Sep 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287731; cv=none; b=p1Wh1oxBdngAkZbRNCagPsnAYf0ZP87bQglTgWGfwjz6cENTRA+YNC3bmK3jqOWmcvCNxjT39TaAfkmopTMiVy+v+uFR5RpRyX3CmHB8VWEleg8xII6yoUICvtOt8GP1sUNKeo2x+aUclohA1PvsNKJCkfgJv4DMfY/HS1Z2Ct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287731; c=relaxed/simple;
	bh=+njE/EWZ2vbZhD1t580nVJGyiei8r/Z2qyRaJny3bMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RQ5sYgyuRw8QJuszBlqS4Y6xkTx3loHMS137CScA2AgHTNj0tOJMLRRvQf1k7reQj3zdm2GEuJy3H+6akFMOlvZCOAzZPctFx1NJp6QiSppdb8F1en33TPrC061jocXNG3GQpOtFkTgJPwXjoANT1g8Nix4F1eG9DxPVEBW8cWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Avd37Yp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kP/fdK6f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Avd37Yp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kP/fdK6f"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788287727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+njE/EWZ2vbZhD1t580nVJGyiei8r/Z2qyRaJny3bMI=;
	b=0Avd37Yp2Rz0fxSPf0osk5w8K8LpmP+Ev7CvaD+N0Phwjqf8ix7yrnmPheu/E0sA+lNZng
	QjMDEhs/m75uUuUcxTtcAJbx+KluMgMjs/XmsV049F9C2kOKNRP4oK/kpue61o1g9lwGsM
	X4xQyqzZp62KbOUruwBCHJPF7bl1L1yHUstqdGIGwbYfzXPf5o+cYhNQWBBfbhu8ZhkbMz
	VZppGc9dSUEVLKse7O6q5/qiZ+aNBDam54YPbudXCWZd11QbxamRVQ4Vc7Pv6QY6pWEM7o
	TXPYgmoeyt54YnqSoBFDyily0VaLH6sIFF/khu6zdzXDl6EOFFVMjBqId0FUWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788287727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+njE/EWZ2vbZhD1t580nVJGyiei8r/Z2qyRaJny3bMI=;
	b=kP/fdK6f6o0NpxLBfM3iNSmVfW8Hqcu+msjsAwJGafDgPJD2f2TkpUFetB+WDnZQiLe8AG
	ieletAWiGvRVppAA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Date: Tue, 01 Sep 2026 20:35:25 +0200
Message-ID: <87se3sakgi.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Extend the rv userspace tool to load BPF monitors, those can be found in
> specific locations (e.g. /usr/share/rv/bpf_monitors/) and are plain
> object files including BTF data.
>
> This type of BPF monitors can be generated from rvgen using the -b flag
> just like in-kernel monitors and, after manual adaptation, can be built
> and run transparently by the rv userspace tool.

I am not familiar with BPF. What is the benefit of BPF monitors,
compared to the existing DA monitors?

Nam
