Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF32848BE;
	Mon, 10 Aug 2026 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366809; cv=none; b=P5eR3fknbD+mc17AcEMuNeAdkaOzCebWaFw2c9tnzWfniBcUE7AJa8TSJJX3YcO4tOqmjoiAkOkZ2L754KhVovRxTcQP9A/JpRiE3ckgQrj2Y/wsXot0TGfTbO4+eYKl6Ul4pK71who3Vy57w7ptKPzt5v+LNtqFzsF0js33uag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366809; c=relaxed/simple;
	bh=/9VGicKG6nyuq1SKx3gyYMHtWSIUoQHAYL0RmFY+I3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8UbDBXo5xAzg4grCF7XokS0IV8xMl9Ihx1LzojdkycXvChXbh9B4heEdEUWeu0a0L6TDkP0TIBmiZz+10SgmNLPt4guoMzlGQYFsDWRqjnJ7kvJIt3eHAVvdaulUpzNE8SqnzFESTu1GFvf1CdT9uFXQaO/62UAk6OoQvDG74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dlKn8FG4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dlKn8FG4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/uZwkHPhKce8IirCrRsgZVUYno7hF2WlFdjhvdb1K5o=; b=dlKn8FG4LNItQDxFo2zEU4yymZ
	1QFN0RTbUvkhrysjO+nK0Go0UwbydLCMSHN18A1pdGYzx4tUhcXQ9evT8FVDKFN/ffK+kiFE7UDm7
	9yzXvsUGHx4tQjvtaV215Hmt0GTSbRnWAR06JplP+cULNbpAV2rZy/7QiWn2NZk0si4mx171sPbHF
	hrlwiJgm6j8XeAwMU2lLfXvJ5VwWOjKaApGUpiaWzw//CMwQOze+Fz+VT99It+yYNRDXKtzNu2BQg
	NzJqZgcdzMCcWugfxmGk9tZ/izvJkC/pYkgBamjJf6lHRQ7qndYyXn21AQo0OzvGTk1B71EN4hmsq
	ytgbiiZQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtPbd-002lfX-2N;
	Mon, 10 Aug 2026 12:59:53 +0000
Date: Mon, 10 Aug 2026 05:59:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Message-ID: <annJFhJU5XVE8NKm@gmail.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3>
 <anXqMsJ14r3BAbMG@gmail.com>
 <anYHjvJ1_4dDjuzw@gmail.com>
 <anm5T9FazACqOWXF@willie-the-truck>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anm5T9FazACqOWXF@willie-the-truck>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 12:43:11PM +0100, Will Deacon wrote:
> On Fri, Aug 07, 2026 at 09:29:12AM -0700, Breno Leitao wrote:
> > On Fri, Aug 07, 2026 at 07:58:21AM -0700, Breno Leitao wrote:
> > > Meanwhile, I will try to ftrace the writes to PMR and regs->pmr to get
> > > a better grasp of the states machine we are in (probably on Monday).
> > 
> > It seems LLM found a very easy to reproduce this:
> > 
> > 	bash-5.1# dmesg
> > 
> > 	bash-5.1#  cd /sys/kernel/tracing
> > 	echo 'r:pmr vfs_read bad=+0($retval):u64' >> kprobe_events
> > 	echo 1 > events/kprobes/pmr/enable
> 
> Nice, that triggers straightforwardly in QEMU for me. The diff below
> (which implements my suggestion from [1]) seems to fix the issue, but
> it would be good to hear feedback from one of the Arm folks.

I've tested the patch on my machines, and it fixes all the cases I've
got.

If it is useful:
  Tested-by: Breno Leitao <leitao@debian.org>

Thanks for looking at it,
--breno
