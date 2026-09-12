Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964E42048C
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789207228; cv=none; b=XN842lw8kOcltkn8SPPjuZIcsaAdZVXMKZO4vLTqXIKQ0XCqGTpXUt5RavqN0Ky7WZDdh7ADYqXBgkyaBpQakjFp9tJn/0SDNHOIsxcawX4EE4MvDxIs/Deh7eE3KlrT0gh3b5hGAAXsvAUEJ9VnT2/bvgnoqMm+tJDV1CEwMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789207228; c=relaxed/simple;
	bh=vgEvJhBtuUvghyoh6FAnvY5qyJ8xRJ/hrt1GgwkKcJY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=nAXScCegIN4ClVCGhV12Sr3G0/Ze63nPDQaqFdnrxrdJDMMM08BTqAVfvsf80pgkA/wG7Uh0CJBmLHAooznQSLBK0n2GOcC56/yAsCg/5lYbhVSUPl6grd9551CSweN/1TWlmqfSidd8oCI8LnOjdNKzhQItEC8VhNJvRkmezJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W99OyGg+; arc=none smtp.client-ip=91.218.175.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W99OyGg+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vgEvJhBtuUvghyoh6FAnvY5qyJ8xRJ/hrt1GgwkKcJY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789207225; v=1; x=1789812025;
 b=W99OyGg+w9qfd3AH2MdbkVUgLnUuncuSl7sW655e0BXe9vzo6xiUSMNMXqlJutsdNV1KFZuA
 iq9Ap8ix0IWcjhNbPSi7FgcfdUIhXUTeGRNxw312sxlYxoUriAunU530b5OPyEFX5MJ/N/BUgfb
 z9s220ER5VO2Q2bTJGh+UMiI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6f6fd6898eb8f9e3;
	Sat, 12 Sep 2026 10:00:25 +0000
X-Mizu-Trace-ID: 6f6fd6898eb8f9e3
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 10:00:24 +0000
Message-Id: <DLD90ZPDMR2Z.1YS25AGMGAB7O@linux.dev>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
From: "Florent Revest" <florent.revest@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Jose Fernandez" <jose.fernandez@linux.dev>, "LKML"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com>
 <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
 <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com>
 <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
 <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com>
 <DL4R2YXF9J8G.203VBANYFFSET@linux.dev>
 <CAADnVQJ+OJKmgaDM9B58g30M_-pkZgGmbDuvEWmrg8U_ZkxbSg@mail.gmail.com>
 <DL57W17T3VEC.1EJMWXYOB7JFU@linux.dev>
 <CAADnVQJLNW=FqPrWq7MX28iA_Qsw_N1mT923WrVkoqES1ZArjA@mail.gmail.com>
 <CAADnVQJfvKmtD=jcOjaYaNAcfmujQm_oE7oNefTGiAAbTFj4Jg@mail.gmail.com>
In-Reply-To: <CAADnVQJfvKmtD=jcOjaYaNAcfmujQm_oE7oNefTGiAAbTFj4Jg@mail.gmail.com>

On Sat Sep 12, 2026 at 12:20 AM UTC, Alexei Starovoitov wrote:
> On Wed, Sep 2, 2026 at 5:48=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Let's extend ip_after_call concept.
> > Instead of using a single NOP after the call to skip fexit progs
> > let's add NOPs in front of every invoke_bpf() including fentry and fmod=
_ret.
> >
> > Then on tramp destroy patch all nop-s to jmp epilogue.
> >
> > llm-s helped me realize that fentry has the same issue.
> > fentry prog A can sleep
> > while non-sleepable fentry prog B can detach and things will crash.
>
> Florent,
>
> are you planning to respin with the above fix or should I ask my clanker =
?

Sorry for the wait, this week was busier than I expected! I just sent v2! :=
)=20
