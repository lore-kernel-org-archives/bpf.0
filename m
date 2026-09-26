Received: from out-zbxj-a78.jellyfish.systems (out-zbxj-a78.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F633CEA7
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790387078; cv=none; b=cjK51Cqxc0twANudy3FgOaZYGL4yScBM2VWAtJYi+/xZE2UpljBhGNzOAw5kOGRKJgEBROuzbi7LD2yz/TjewmV1oYMbpuwznTg0bd3BI6D/kJXh0WNSNWJ5NayY9PAPesp6QUpcJlVaN1algVNwrZyJC7Ztu4W1xSA9tLYcEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790387078; c=relaxed/simple;
	bh=VHIw1jqoLRo6+Mo0bxOR2W3IJ5NrOZ9nWmYQHzKyvcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLyCEXM75AmKYz2gaIPzxCWcugGtLFGKkNCrE3+ykP03zYd5goUrupMgyyIi7zgLIwWfiUQIAp6PZEIdh71TDtRQvpuIDEy/hDKbxSWB6TFlYv9e4GCsqA3RuXomjCaOAw6bxShg9liLoe4ADEeO49GSPGEh8IiVKs1pdhLmP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=RV7y3I16; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="RV7y3I16"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hs9NN330Vz6tmS;
	Sat, 26 Sep 2026 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790387062;
	bh=VHIw1jqoLRo6+Mo0bxOR2W3IJ5NrOZ9nWmYQHzKyvcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RV7y3I162eIzCeF5xICAhsByD20NDYJqHfYEN8LtMJaFojljp7PPRmE6bVaxaRBrK
	 1qWlkBtKYYf487/tc5RpYLAQodHlWRZnxhG+gYlPq6TRpY0LNAKoW0tvE0XhHv/RrG
	 brlHUVTs1tGmUFJ5NaQxxfSYhA39VbQLs/EPStxZb/ERS00bQBmhL5aru5edBSab6O
	 iSaezXMt/2FLYU5Bai6bw9468b/uSl+fB7Q66Drq7di03F5TPagC9e2g56eBGO6FpJ
	 NXOpZApybMnDlQWs30RveUMX3rCZZmyTxjI8YOAwlRhGPgXbC86MjR8Y4/Trd34Cq4
	 RL5eYQJqH+Msg==
From: Tianyi Chen <hi@tychen.cc>
To: qmo@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 1/2] bpftool: Add recursive map dumping
Date: Sat, 26 Sep 2026 10:44:18 +0900
Message-ID: <179038705821.25394.6011108837604232801@tychen.cc>
In-Reply-To: <43549d30-0f47-46a2-a60f-fb6f252e6738@kernel.org>
References: <20260925174402.2028649-1-hi@tychen.cc>
 <20260925174402.2028649-2-hi@tychen.cc>
 <43549d30-0f47-46a2-a60f-fb6f252e6738@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi Quentin,

> This hunk is no longer necessary now that we use a keyword rather than
> an option, please drop the rewrap.

Dropped in v9.

> Looks mostly good otherwise, but Sashiko's finding seems correct, so
> please look into it.

Confirmed: v8 incorrectly formats a non-BTF map using the preceding map's
BTF. v9 clears info and resets len before each query in all three
do_dump() loops. The two new mixed-BTF regression cases fail with v8;
all 15 dump subtests pass with v9 in an x86-64 VM.

I also rebased on current bpf-next plus Maxim's v2 implementation patch,
with that prerequisite identified in the cover letter:
https://lore.kernel.org/r/20260926014208.24773-1-hi@tychen.cc

Thanks for the review!
Tianyi
