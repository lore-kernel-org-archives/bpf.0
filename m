Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5637262B;
	Thu,  5 Mar 2026 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679627; cv=none; b=kJtB4cShq2MRvcDESL2J4RibuFKE//SZ7n9wP1z93h4r/OyAIgPndepGxqgqNtAzqUqbkS3vL17qWUyRF1fbOQ4osULorbeAwgoV+nKohi3NejFjErYt1HEJ2aIwbnncz2wLTg4zUfa2f2ICyvGH5rcMonoOHhKWdNVC2NtcJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679627; c=relaxed/simple;
	bh=cHwGQKmPsWfWcixUcZF+n3NEdYoTNBQLxPJ5tpvRZ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sg5sUlqn8Y9kxYQp0NF/zAgFJI5cY1uT7d23GImYzL+RzESCtc4Nho45R5bgzyVADi2MCzY+EMKZIO2eW5mTFSuLx1hcbzXAkjnhxv7TBF9Bihqmp4VXiryy8OxIoSwz9xR2nHsJmMQ9wFjEiWBynIpcmhRh8+GiPYlLSVVxgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id F167DC1BE2;
	Thu,  5 Mar 2026 03:00:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 35C1E20024;
	Thu,  5 Mar 2026 03:00:21 +0000 (UTC)
Date: Wed, 4 Mar 2026 22:00:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304220019.3efa12ab@robin>
In-Reply-To: <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
	<20260304155742.7b4de2d1@gandalf.local.home>
	<20260304214447.3e5817ea@pumpkin>
	<CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
	<20260304212802.458b878e@fedora>
	<CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: emwhu543p3pwoujw7dyynb9qwr851643
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 35C1E20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/MmNAFKuSCqyQHbBzziQMMEAQdPmfUGeE=
X-HE-Tag: 1772679621-783041
X-HE-Meta: U2FsdGVkX199bnlpv7btDLAB2Hr/Dnq9eg3ysLcOievMW5PQMLatt3R6dXMKY043RDknsKNNLyvge8f056/MlanNbS/SlAiw2pjHziJZoPbVRyOxAJJF2yV6IevmjQtQXcTMy4udaJrgmixx5YM2nJT7Tj+14OLA6n3WcYD62D3PRg4YZuTsB7zZxf6sXFLEB4+YGzX1ZF4uoUN6F1qtOIlt2Ez902dYq87obCP2NrcrlgoViKA8CQq1sDgRuOwzG8jDy7wTYsDQdEbBfNYlsHGMO4rEQeRKrWgOMsWLLo9FOOk/MkeIZyheKvrkGQmwpzTVeh5xckgIGgYolej9dAvatj5u6xJpmjZ1ipTuOZ9KmAqyc61FGA==

On Thu, 5 Mar 2026 10:33:00 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> Other tools may also read available_filter_functions, requiring each
> one to be patched individually to avoid this flaw=E2=80=94a clearly
> impractical solution.

What exactly is the issue? If a task does a while 1 in user space, it
wouldn't be much different. With PREEMPT_LAZY the most a task will spin
in the kernel is one extra tick over a user space task spinning in user
space.

available_filter_functions is definitely not a hot path, so I
personally don't care if it were to use "nospin". My worry is about
adding this "special" mutex for a single corner case, and I want to know
that its a real bug before we add something special into the kernel.

-- Steve
