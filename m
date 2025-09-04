Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE115E5BB;
	Thu,  4 Sep 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997274; cv=none; b=gIUMSg4K+alAYLJDO/0vc7CWzOCh5yufpyFq5UaYyufGGmVvLbZOdpYVvsv+NiVvO3Bmk8JALeE0MdqYuCXMPe3ASd+qPqCEsnlNqcgCxzX0nUeKrpf9GvcRnNEN7Zb1QgyXSvvpJPC6FJ35IjTpnq7mF20vmCKTDHMa8qX7VGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997274; c=relaxed/simple;
	bh=y60IvqVsGUXKmY2byeEWSP/rsNy58T/Cv08HJ1b2610=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pd6W0/6WrqmHtslv49YlYDuZAOFrZsnqoPd7E5XSYC37S8hKeWc86MFkO5HPlEQQxfLysuuCY0KWYhJFzlav4eDwWAQeCan9w+zByk8hycJEQPeWUMxpaHBc7pYsmBnoxbxbcSkGdOTcvxX2evn5j2KE0Q5YKG+mUZeB7wa694U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbbUa3G5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbbUa3G5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83818C4CEF1;
	Thu,  4 Sep 2025 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997273;
	bh=y60IvqVsGUXKmY2byeEWSP/rsNy58T/Cv08HJ1b2610=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dbbUa3G5IyIKvCsWGzohdR0fHKYrruuAXv8Z6FcSmuu3GtrbEj5xPphbEHL+m+MVm
	 WNqU5Y41DXbThcMRBjDjdESVdE3BV1krQMpSgzDVCdQTqJcaBqs3XHhT62v6JwYJpy
	 1OA15LcKxY51CCYUsS6e9xrmEeACNLY+cNoLUZq+gLAWNNeLRYX5EzR6tZymnhsZ4d
	 T0zagrZUZ7SuEgIMFvFCjrGz7CJWDx+tjvvEwz8MzUmtm4qt3RlWAWwI/5wSvtDFV5
	 zb656oEQMheBR9qwnncPgO4R6j+8aWmPdlStOj442tK2+lEjYuBNuWEVLX9d678WD1
	 E2GFcTVLpBStw==
Date: Thu, 4 Sep 2025 07:47:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: syztest
Message-ID: <20250904074752.352982bf@kernel.org>
In-Reply-To: <20250904141113.40660-1-contact@arnaud-lcm.com>
References: <6887e3c8.a00a0220.b12ec.00ad.GAE@google.com>
	<20250904141113.40660-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 16:11:13 +0200 Arnaud Lecomte wrote:
> #syz test

You are hereby encouraged to not CC the vger MLs on your attempts 
to get your patches tested by syzbot. It's not necessary.
