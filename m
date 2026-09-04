Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA34FC8C2;
	Fri,  4 Sep 2026 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542602; cv=none; b=J1Epxt9XraM8k074pu3wFqaim9BqDVF2z8yNqXpG4R2YN23yxmxmSpdNtiAjsfFZRVptqJqaCT+JthRGtWsvPz5hwBqXbwZf1HYi1Vvy3kn1TXReeUn5lfcrffOlaEXdFcwAPmTDeLy78YnVdYvZUiAW5joghQdb5YndnqLIvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542602; c=relaxed/simple;
	bh=PsNkvNAMERvKhkJRsiwcllB38I1dTcLu898sCxRu5B0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAquBuwKzSIIXAROHykb9YXZ6YYNP4hcNIhNooczhtZbkIQ7fKnNvbWYjr0JAG0I5xecMNnNu9QqPo+Kk1XCSIaZZHBWNgLh+h0WFT7eh6ZKTXKToDmXcgWmdStchfVD8ksWxEl7BSZx2QSZqVKeUolcN/jyYcxP4rzlViyUmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=ChM3J2D5; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="ChM3J2D5"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 7DCD9160199;
	Fri,  4 Sep 2026 17:23:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 6C05360010;
	Fri,  4 Sep 2026 17:23:16 +0000 (UTC)
Date: Fri, 4 Sep 2026 13:24:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Gabriele Monaco" <gmonaco@redhat.com>, "Nam Cao"
 <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
Message-ID: <20260904132421.111c0279@gandalf.local.home>
In-Reply-To: <20260904123108.1fa1d815@gandalf.local.home>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	<87se3sakgi.fsf@yellow.woof>
	<df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	<DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
	<eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
	<20260903090211.50d15220@gandalf.local.home>
	<CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
	<20260904074317.01b2c0e1@robin>
	<DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
	<20260904123108.1fa1d815@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6C05360010
X-Stat-Signature: myzefh65tijod654h85trkiyod57oirt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18b9nimytvkPYuMSkULv6tMxhPgDVl/eME=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PsNkvNAMERvKhkJRsiwcllB38I1dTcLu898sCxRu5B0=; b=ChM3J2D5NIKP2tazYRrjpuvRU6kCIJ7AT5jSzAYv+AWjK7HlL2gXDjDAFO11BWPCIZP+bxNCINKLBrj6bn0TdOweeS9xstNLGBnG5fAh8p2S+dSs0MwrZcIaNng1uaGqZ0nXA/cPrkbZSlUfaLox7D9WHL06OxM/SCpO8xTNYZU=
X-HE-Tag: 1788542596-684514
X-HE-Meta: U2FsdGVkX184UWi/P31aPRgcxGaJqERNlOHy8RrCKApz9HNxvNF8X68pmmChE03hP1fEWk1GaWR/xP2B5eNcfcGiH7sqAreDzD2zqztTjrWr8yMGBIBn/FTHgtfaKTcwDvtsq3IoPi/dR4bGsTlApIpdXF1oj+YIt+nJn6r2zFcYaoLuq5utUmFZMAMK4GBmcgnusvv26bbMlhQGpuM9BMfo3WU9BGSUlTho8Oyv785MFkieHPRYPPNg5Q8dXLOWm4yN2E8vqqJQvdHwuTh3EThEAHwqqcR4cEmMpbchDi8/LnTnHM6g9q+arKtNppSU41z+s9OYmxWo5Ec0EwkhVBEPJfNqfky6gFbb68UH8/lOPCNaevZJgO666l6PwQ0q

On Fri, 4 Sep 2026 12:31:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> In the beginning, Daniel Bristot looked into doing this with BPF and found
> issues with it. I do not recall what they were and unfortunately Daniel is
> no longer around to explain it. Maybe Gabriele knows what they were.

IIRC, Daniel even told me there was a competing effort within Red Hat to
implement the same functionality using only BPF. That effort never
materialized and everything went toward the RV code Daniel was working on.

This was years ago. Gabriele do you know anything about that?

-- Steve
