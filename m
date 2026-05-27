Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABDB37882E;
	Wed, 27 May 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910241; cv=none; b=r6AQu8ICgEdMGkVK32qlTom0kjDQSyYB4eSAr8yWR45ajA8LrLrUF8DrbEWxfOGshl+9znzlZ+w/zkWE2EBgN5Edqd9mkXVgoRJ+Q5g5U8EKkIxDuVCGJ0mYPYfSNO5GcEUA/ByAuAfv7KCTBrfl3ZHz7N1l7XmOibTNaU5IGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910241; c=relaxed/simple;
	bh=wOT+J3Fc4hWTCwLly0QIfPxaKtZME2bmy1i4ggxiAQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pnj+QrioJLpvb74ao2gyuLast9zmhqc1R22mPlTw9zvTj7Kdhd0AcGjvqVH31qPYIoOhCstAbdUONVFJ9UnjwC2YOs2o0Y0EAso46ETg0lexMXji9prfw511UqLkITjahtHFMCQrvc78NDZ66tjJC4B+wSLhtaaoOJ4qcbUhmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id BF7EC1206C7;
	Wed, 27 May 2026 19:30:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 3DC4720032;
	Wed, 27 May 2026 19:30:34 +0000 (UTC)
Date: Wed, 27 May 2026 15:30:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>
Cc: "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Uros Bizjak" <ubizjak@gmail.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Ingo Molnar" <mingo@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH bpf-next] x86/ftrace: relocate %rip-relative percpu refs
 in dynamic trampolines
Message-ID: <20260527153033.6f4d6203@fedora>
In-Reply-To: <DITPAGA18EUH.26LNYC9K9KX1P@bootlin.com>
References: <20260527-fix_call_depth_in_trampoline-v1-1-d0292bfe7eed@bootlin.com>
	<DITPAGA18EUH.26LNYC9K9KX1P@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3DC4720032
X-Rspamd-Server: rspamout06
X-Stat-Signature: aqhid386mcdc46fs4xwyfrt9eiq9cf3d
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++8RN3tWZpDxev7UPoHpOnE9IVvECW4OM=
X-HE-Tag: 1779910234-863024
X-HE-Meta: U2FsdGVkX1+DTv8MUBp3mbNcRUKYvbchthGiUHYWqgC266mpqcg662PZY9mALMPtY09/e4nsbiNCmlhJf7pzuCTLXwZQyVEIBVQbRL0zwZRRmId7DtK0CMiaOYdElWzBoVc/NE9k2eb6Rxk8XZwIR0nP+35CNkW7IM6/OVfz1PKxyhG/bGgCE/uNwxkuL/MOOlh8k4iceVfotqzUpTP//bOkV3ji7kNEq39mtgV/xbnAofSi+0Up2VLhELMmvzd0jVorRbXp2LblXFGHsDo1Y5uV/mckAPht62dZwzIPyxxpJsQulBqkjo6PCy2NZBiC04ApwJNPvOY7XkJKZfmjHob6WOA0zGO7wX9sQCJTxPi6ilCYZpfFIrkhpWKK4Ioyw08xzq5wi6lkrlimgUIpUTEM3n/KcEa5fQaeOyD711GJ5zq1UOxm0MF27f1JAlKO

On Wed, 27 May 2026 21:19:47 +0200
Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> wrote:

> On Wed May 27, 2026 at 9:08 PM CEST, Alexis Lothor=C3=A9 (eBPF Foundation=
) wrote:
>=20
> [...]
>=20
> > Fixes: 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to=
 PER_CPU_VAR()")
> > Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bo=
otlin.com> =20
>=20
> Please ignore the 'bpf-next' target for the patch, this is a mistake (I
> used my bpf tree to prepare this patch), I am really targeting the trace
> tree here.

Actually, it should go through the x86 tree.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

