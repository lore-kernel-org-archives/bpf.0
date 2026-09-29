Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E0352005;
	Tue, 29 Sep 2026 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647408; cv=none; b=KJVWvluOyeRRwvd4n7pgmxQ2bXSuR9nFukhJv9UuY7Fz4Bu6b8e+dE+FLN48udU9isx8A8DTg6CLoV32AoGrE/9MrKKKxsY67t7l8q0qIC3AD4AdUS61A9ST+gjzNN/OlX35tovgCaOsVv4VMn5q5tP7cESSD/2KOHTC0KkVNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647408; c=relaxed/simple;
	bh=ZBMUR/UP37PTN9oIQ+ZjaRyshqfQZVJk5BEgfVpTJiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7LeVfzkOE1/EZKWJDdhIgy9P6wM+GAk6zHEqxpvzgwpeCXBN7KCDsDBipnhVh/b7ptPETN13guOXtUvnRdGLa+BQq+N58590xIUnlmqiyQAWAbwgStBU/nvumjW/TYcqVJN5E4MvFG+/CKxX/Jwz1GMqQ9QXJ+RxcSFkpz0vZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qbb09QQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qbb09QQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12551F000FF;
	Tue, 29 Sep 2026 02:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790647407;
	bh=BFLTngY3lou8jfRcfO959+jpcG2TvKrG0CgXxbCybtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qbb09QQ1O4oESUNgMD/szA1sB2OxtHAnwesxyTAq0sRGxkW1RUv+ARE/qyCJ5xiTH
	 jbsJ/FCiR32Do68+sNuw/Y6sQkPFgfT5SGu8fOdR7M+FExwNh0Y54nbYMnqiapeX6m
	 NbM6aAi5zFU41Y4wA5BawsVUW4KEILosxv8ENIP9hZ3eG3cDimanLRL4C7ddD+ibhd
	 jX3bTK/IVRrIn7rQLBOJc25vY7gKwhgpMFHYiZgstzVbaeyOiZnerv5H2Vhl5YyAOW
	 20ZcE0OAr67aPPFbS/jq+cFOVxUJwkjkQp1Oi2NJcI29vp3RTw2mHqdJ4QFLBQy+v7
	 sZtbDk0zwpPtw==
Date: Mon, 28 Sep 2026 19:03:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: <netdev-bot+sashiko@kernel.org>, <alexanderduyck@fb.com>,
 <kernel-team@meta.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <dimitri.daskalakis1@gmail.com>,
 <mohsin.bashr@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 8/8] eth: mpnic: add basic Rx handling
Message-ID: <20260928190326.59784ee9@kernel.org>
In-Reply-To: <DLR1SNM0T642.1TU5R4E1EQQ32@gmail.com>
References: <20260924-linux-mpnic-v2-8-4badc9b58b9e@gmail.com>
	<179055370821.3145.15563353156431464401@kernel.org>
	<DLR1SNM0T642.1TU5R4E1EQQ32@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 11:17:42 -0400 Daniel Zahka wrote:
> Valid. We prefer to address this in a small follow up series. 

To avoid misunderstandings - the Rx stall watchdog is intentionally
deferred to a later series which introduces the service task.
We were trying to keep the initial driver under 3k LoC for feasibility
of human review.

Acked-by: Jakub Kicinski <kuba@kernel.org>
