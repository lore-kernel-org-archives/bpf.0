Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891418FC80
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190938; cv=none; b=JkgsAqsGizh1vJv0vZKdDDhQiMxeDNNpcg3/hMOHtGXK41GdLl6Kd6xWu9OgrRs6mIMzQzMUi+BtZe2FnCMhI0g76Bs+115Lh456lBaCGy+aKI8yC3r69AiYP2TbaDVYboeQoSbB6B33gaxYqQKuYQVq59cBopmXq52rVaSIdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190938; c=relaxed/simple;
	bh=Khclay4ecX/nvSTzaAdYgZTjX4dAoCrM/RS7sm1vF3Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=g3w55DYWkXIKXx0BvbHwXq8D3pb3jtr/6ox+pRlfhDLdneNYx9nDX1ofJcx3I+45wk525i41qC52act+nukfsFIq5amw9tQeCUR5MKfoyYqobrx/jFwnWtypIvoINKdPrx/7QbB+/eeczBBRaPTSJ6vgKGsJK9IST4v/U3svPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=l4oC5xWt; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=HI252zYN; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="l4oC5xWt";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="HI252zYN"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792190930; bh=Khclay4ecX/nvSTzaAdYgZT
	jX4dAoCrM/RS7sm1vF3Q=; b=l4oC5xWt9YUECOyayo4HsAExkhRfUqeJZUY3+MzqWjYEUMjyop
	ONaYVLCwA824y2yINEt55Q+BVnQxh8GRCQsg22U27JarleW8uwfVby+Xv7eQ43wEy4UsCD3YDCp
	WV+AKzO7hoZGjz8wI+slviuhn+FgTUmteDhSIaJdxE8AO/IIWvH3+Fmgh2XuSrKZ5jYMDlrJCWA
	6HJP9QHve0OwoibeGtIo6kIYK9g6UCxzEYo5YTpqC3Zj8ppD1dGP8hW1EmdrCNxK0MwkE/iYQVx
	r3IZq50K9k3YRYZCEX2jSEWLYW929ru8FiPfC58aKsQ0Y0Dd57a6cM8HuTE4sU1ItjA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792190930; bh=Khclay4ecX/nvSTzaAdYgZT
	jX4dAoCrM/RS7sm1vF3Q=; b=HI252zYNQp1lvWqwMboQKf87y83ZkHhvrcoElZlMk2oBgAzP5f
	upFzyt5ili2Zvf9IaOQSbz2mlATT10ny2zDA==;
Date: Fri, 16 Oct 2026 23:48:50 +0100
From: Bradley Morgan <brads@mainlining.org>
To: alexei.starovoitov@gmail.com
CC: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [ANN] Five questions every patch has to answer
In-Reply-To: <20261016224310.3135990-1-alexei.starovoitov@gmail.com>
Message-ID: <612182E8-6061-484A-8196-61916ACAE292@mainlining.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 October 2026 23:43:10 BST, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>Hi All,
>
>Two AI bots, sashiko and bpf-ci, review every patch sent to this list.
>In six months they reported 522 of 636 known real bugs in the posted
>patches. Median time to review: 19 and 53 min. First human reply: 15
>hours.
>
>Reviewers: leave bugs in the code, bugs in the algorithm, nits, style
>and commit log wording to the bots. It's wasteful for humans to spend
>time on the same thing. A series can be free of bugs and still be the
>wrong thing to merge. The bots don't look at that.
>
>Submitters: the five questions below are what your series is judged on.
>Answer them in the cover letter before a reviewer has to ask.

Hi, I learnt these could be accounted for too, what do you reckon?:

1: Is this a hack? If so, is there a "less hacky" way to implement this, and
is this absolutely necessary?

2: high complexity features with no use should be naked.


>
>What reviewers should ask
>-------------------------
>1. What is the problem? What cannot be done today, what is slow, what
>breaks? The commit log often describes the mechanism and leaves the need
>to be guessed. If you cannot tell what the problem is, that is the
>review. Ask.
>
>2. Is it worth solving? Who needs it? Will anyone hit it in real life?
>Is it measured or hypothetical? What happens if nothing is merged? Is
>there a way to get there today? Every line that lands is maintained by
>us for years and not by the author. "No" is a normal outcome of a
>review. Working code, the effort spent, "it's v7 already", acks from
>other people don't carry a series when the premise doesn't hold.
>
>3. Is there a simpler way? How would you solve it, given only the
>problem and the tree as it is? The least code and the fewest new
>concepts. If your way is simpler sketch a prototype in the reply. Pseudo
>code is fine. It's better to discuss code than a description of it.
>
>4. Will the api and the layers last? uapi is forever. Is it the right
>layer? Is it a second way to do what can be done already? Generic
>solution or a hack for one use case?
>
>5. Is it good taste? Many solutions work. Pick the right one. The bot
>asks: is the code correct? The reviewer asks: do we want this code?
>Nit: name of a local variable, empty line, comment wording, line wrap.
>Not a nit: code is too complex, wrong helper, too much indent because
>the logic is convoluted. That's taste and it's worth saying.
>
>If you don't like the answers say so first. Don't bury it under comments
>on the hunks. There is no point in polishing code that should not land.
>
>Submitters must care about the why and the design, and answer for them.
>The cover letter has to say what the problem is, who has it and what
>else was considered. When a reviewer asks why, fixing ten more bot
>findings is not an answer. Review your AI patches before sending. Send a
>reproducer. Review other patches.
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
