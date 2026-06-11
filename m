Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C920DD51;
	Thu, 11 Jun 2026 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185611; cv=none; b=L2AWcKXRtHf8dqyQSZfp/DE7vrx4ZydjZ8gYsZwZmbSIpQ42Xe1hUbUGNct8QjDfRWHHDUHQK/9m5SqYEDlPMTVWlV2XNTgbpc9dKFR+wuBZLVjKIYr/B6vpLn98Gc8nOTqi/n4uOn8kx/sVaiI15xVzm8qkGKlKuQmuiFs9KpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185611; c=relaxed/simple;
	bh=8UkFUw0BC2HFE/GKOD7ynv5TTUs1BpeLZ50aK6J+YDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owjC3hYJAwNdislADUkL1dvxJBra44Q5r0W8nXY/cofDgBmacFlTy/TS6Ipkz0Qq5UfHwEiB3r+aNZ/ZrEFMSMktYPMfZVia/fd+V6hfv7rbDpZ+Th1E2Lw59ByElzPxK/si0QkrrktDXlvb0CbkN34HsmlOa+drUMlVwamnlHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEbmNWwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEbmNWwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5431F00898;
	Thu, 11 Jun 2026 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185610;
	bh=+V+3nnBYkmFHSCRQ29hQfoMSLYLoUwxadsdsNk4AgrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QEbmNWwmVjpjqf03KAKY3XaOqNjTHrTzsPlhf4/bo92l1zjE9dDcylbYsNUwLjEeU
	 6oo1BoMEzpGPo5zOGTDeqTlp9dZJ++j2M9tYXSKKtsynrs8gaQ4kv7DXoJumFaAuf4
	 mh5dfaaydS3MISLuYI4WGAUzEsm52cupc/Fxo3wIvMbGmWvRkZCT/m22hANBmD9KsT
	 8ev6No6SURNaz4zeFr/D2edCBGwGUIrk2HJzqihzERlq8ojMqmVx2hGgPpRp4RYoi+
	 eRwN9IMoGctTcJPhh3xgq0C1WDZ79bpBx+SPs3YjkrJm5/Phf90teuLmKUO0EZT5ez
	 SM75fsnFiPi9w==
Date: Thu, 11 Jun 2026 09:46:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry
 function
Message-ID: <20260611094648.04622890@gandalf.local.home>
In-Reply-To: <CAADnVQ+RhRiUp8FeptdVKZimGd-Wv8C+NbW5U4hh+7Hi5abQxw@mail.gmail.com>
References: <20260603110554.29590-1-jolsa@kernel.org>
	<20260603110554.29590-4-jolsa@kernel.org>
	<20260609102922.3c489f76@fedora>
	<DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com>
	<20260610113536.77172ad1@robin>
	<CAADnVQ+RhRiUp8FeptdVKZimGd-Wv8C+NbW5U4hh+7Hi5abQxw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 08:42:51 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> If my memory doesn't fail me you said it's fine during v1,v2 iterations.

I'm fine with it, but I wanted to test it first. Did I give an Acked-by?

> The last v3 - v8 you were silent, so we assumed you're still fine.

When I see AI reports that say the series needs a fix, I don't bother
looking. I thought that was the entire point of AI; to let the maintainer
not have to review if the AI found something.


> 
> While at it, please review Mykyta's set:
> https://patchwork.kernel.org/user/todo/netdevbpf/?series=1096695
> 
> It's also been pending for almost a month now.

Have a better link? I just get a blank page as "TODO" is set to what I have.

-- Steve

