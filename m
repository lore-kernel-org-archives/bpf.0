Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801892;
	b=mFqAJMNsE+bOjwCdDuxnVgbgt1bP4L9lZaVseeDhwEilF/gK0qGk30oVuaRExK2A5Jk/
	 yxgmrUfSth5ftl8ztUyoUPWNmXzzWuBg7ZOrI5io4QKTylh6cKZiHKqzVsvJL56wjVA21
	 Nsylo5zJtiUOapRKp64DrmTJtW2JgKwyqUXp4IxOOdsbh9R24p9BoxLfHhxdalPIrAOQo
	 Q7C44DdPkYqDfFzVg2XRwecrtIl5f5MwRXkrKjsiy3v62iNe15ugXX+1N1CbHqAlW/if2
	 +RjUrUHXVLEnEi5F7GwJomyIMZTCu8pRRY3ZmL8/DUCuR7SZplSWFqw44UmkhifaFQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801892;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=vaTm8zyMYvne9oPsZa0I6jcRniOKGde2BII9Cy3AZb8=;
	b=39QULR1BH4RNh85YFsHXZqWXza/zKSh/Pufs294J2PB/vS54pkMQsLA8ShwIotnaXBoD
	 8JHO9hoYQmRY+NPT29ev1dVp2EDTqUSyktqNRB+a/TgYrmE0fK4da/j4CPK8FLHcphqfo
	 XyDgSEN90MpkFBA38j3aQb8uVSPsWU51PouCKW8FIclem5nIGSrO1qQXN8y+NrAoL2D6U
	 YsLVLtee7ShVDa3GIU7MWiEXVF3TfaLRtkG8+vZ6vk5+uHezc3C4L2RUNu+rCRPNebTRo
	 cFa5ICDicunQPByPTu1C7h8tpUHvYuXjfpn54MaG7dDXlt6RI3vVWf5VDwKViTQ5Mvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3esDjJI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F6606A31C;
	Fri, 27 Nov 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3esDjJI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4461F00923;
	Fri, 27 Nov 2026 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795801891;
	bh=vaTm8zyMYvne9oPsZa0I6jcRniOKGde2BII9Cy3AZb8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Y3esDjJIzF9Up6hlH1AcD5hSKTw4TMIZkXVJ4XOT8UHBoEqHugiSRBVf2zjTs099t
	 ta6Q+DgSzflJNgrLbIn6SCMhaPBdzsDeJ+AHXU7QHx8yJiu6jnO47zeZd9d+l1bwQ8
	 d6rxHN8B6viOqEZeCGtArwy+5MBkryIP4E5LmLnZAPMw82uTUAAlADHSbwI37UEzq5
	 BcuPWD0sGuH2qJPDgIOR7FlREuXlu38rSLZ+7bJtNArbrmo1I221OVdGuvxzUiPWyP
	 lYiSd3pPmHZfrd7PeqW7Kg8+fekvWOcjTBmWVF6WAm9/C4RYph6jim3fTb0VzbDqIN
	 9xM1N3sYkhn/A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03ABDF40066;
	Fri, 27 Nov 2026 12:51:29 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Nov 2026 12:51:30 -0500
X-ME-Sender: <xms:IcMJa1BhQ_IoHMFIJ21_IM2SR33uXCcL86dAL-fOK4F5qobu75xbZQ>
    <xme:IcMJa-UibaFqtsZUwcRp5MkCrE907PllAh4VIVchq8mErOAVxChnNr8SjKxM9hHn2
    iJ840EgUXiNDsoAg9O2Ew-w0wwI91GnDlzQ1mn7HrANQlg2evRK5dn6wQ>
X-ME-Proxy-Cause: dmFkZTEWY3vXFk6Qj2qtZa3/yffkiMiEG82uJyPASb2q0GY5Qy5oukiV/d76RKewOepQX1
    dauwntytq7LYtWbmiMIgTdMOK8zATV8LTOIILM6xnrmjq2pkW3IpAjy/b0Seuw4mpQWLgM
    makgjwig14S/t6nwwl3mrxjpiPSW9uDf9WCo4FxWqmT78HiDwZDZW7yLDRquN7H9Njt6vi
    JLybuGpNc91CWCvp6ytq47tmtcZQefPWdpkoXofiPQ0rsIMYN6IlBrYl10mJMr4xfwvJPg
    m+ncp88DOezGX0RLLfH/IaJtjeonXJAJwLxeVu2ITf5FrpbJ0HYgYnQrGbWWpIdBQ/xIuD
    TlJlYSTyT/UZ4bKL5XDzyYplljaSAzNqmrLtKFR/wtG4y3qCwSAYXeeR0xDMlixtfdNvnr
    g6A0VM9vPRtXpiKGOxvmx3N8g5Z7CGhEgcs6Fz16KiwQvFQxEi+2SKI1nypdA/7HvKCMr+
    ixNsz580kf/5q0GsPJWAQZLSfauEvWyXlZla7lygpDKrakSc6zQlI2uXhIgjm3ZfdjStxY
    oewtJzzjB2PkV6Sdd333uDmqeAX9VlmNH7tDc/prMjbGHYqXsiWr9vsgLwxF5esDluskF6
    q9nN/RoY9Y3oNQb8lVn34iQAyfuH5C0j4i0BFIkJbeoYN8Qf/D2FshtczdTw
X-ME-Proxy: <xmx:IcMJa_li-4YRPiKEExkBLv3Wu3CXF_T5W5Ss1XG01JRBOKHUurfgFw>
    <xmx:IcMJa7l1qRxQf0O08tfQW_hLIwJs7eEnuwurUI64AG07fpRw2c5WmA>
    <xmx:IcMJa0V1FrMqrS3SZmy_BB14ryMme9BMWghWHskuzF_lX61R-QtZ7g>
    <xmx:IcMJa5-DosFbiQ8bvLfJg4iZQGwoUAbzlHnNvO05l6lY1SSUhSwpgA>
    <xmx:IcMJaxqkvUgBhvJtZXqYr_UlDePmqfHhHZ-4CclZNcUwfNUp3H7RizyS>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D13ED700069; Fri, 27 Nov 2026 12:51:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AisSLPdYCdlo
Date: Fri, 27 Nov 2026 09:51:09 -0800
From: "Andy Lutomirski" <luto@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
Cc: "Puranjay Mohan" <puranjay@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, kkd@meta.com, kernel-team@meta.com,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Message-Id: <7c7695ad-86c4-4b52-b705-71dac267cad2@app.fastmail.com>
In-Reply-To: <DN5K8Y9824AE.3GPOE0WP9ELFN@gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com>
 <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com>
 <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com>
 <DN4X9KVYMONH.VHKD1QED1BUQ@gmail.com>
 <03275761-8de2-41be-92fd-8e3012a87eeb@app.fastmail.com>
 <DN5K8Y9824AE.3GPOE0WP9ELFN@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for user
 address faults under SMAP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Nov 26, 2026, at 4:18 PM, Alexei Starovoitov wrote:
> On Thu, Nov 26, 2026 at 09:30 AM Andy Lutomirski
> <luto@kernel.org> wrote:
>> Okay.  So maybe there should be a nice patch set to *fix* it.
>
> In a perfect world, yes, it would be nice to fix, but no one stumbled
> on it since the probe_read_kernel appeared in 2009, so it's worth
> fixing only if it doesn't kill tracing as a feature.

You mean no one knows they stumbled upon it.

> Kernel observability is a mandatory feature. Looking at 3 options:
>



>> 1. Walking a little list or table to validate the address (which may
>>    require some sort of synchronization and obviously needs to be NMI-
>>    safe -- for systems that use TLB-flush IPIs, blocking interrupts
>>    could probably do most of the hard work, and otherwise a little
>>    flag set while a read is in progress that can block the change of
>>    an address from safe to unsafe would do it.
>
> walk and the synchronization makes it unusable due to NMI,

I think it=E2=80=99s workable.

When adding a safe range, you just add it. When removing a safe range,
you invoke RCU and it remains allocated as safe until RCU synchronizes.
A straightforward implementation would immediately unmap unsafe vm_areas
but defer releasing the vm_area itself until after a grace period. On
systems where the TLB flush is guaranteed to wait for NMI (x86 with
neither AMD=E2=80=99s nor Intel=E2=80=99s remote flush extensions) even =
that is
unnecessary.

The NMI walk uses your favorite wait free data structure, e.g.
latch_tree (actually intended for approximately this use case!) or
XArray (would need to verify that deadlocks are not possible but
probably faster).

> but we we can give uncached ioremap() a different range vs vmalloc()
> then it might be practical with a single range check.

That also seems sensible.  One could do this and the above.

>
>> 2. Allocate a PKS key for the purpose and use it.  (Only works on
>>    systems that have PKS.)
>
> My research showed that the effort to get PKS into the kernel stalled
> years ago, and it's intel only feature.
>
>> 3. Use an entire mm for the purpose and treat it as a user access.
>>    This is probably the cleanest solution but it will be
>>    slooooooooow.
>
> You mean like use_temporary_mm() with direct cr3 writes ? If every
> read needs mm switch that might expose intel HW bugs. I remember div
> bug and I bet there are more lurking in the hw. I'd rather not push
> the hw limits.

We switch mm all the time. The issue you will hit is that it=E2=80=99s k=
ind of
expensive and that the extra pagetable synchronization is complex.  I
don=E2=80=99t expect hardware issues.

>
> As a summary I don't see a practical improvement for
> probe_read_kernel. Maybe there is an option 4 and 5.
>
> The main point that it's orgonal to this patchset.

Except that the patchset is adding arch support to speed up a use case t=
hat isn't even correct.

>
> btw I'm planning to explore PKU for other bpf needs if writes to PKRU
> register are fast enough.
