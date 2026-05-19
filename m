Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708C1EEA49
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158584; cv=pass; b=DPPrrgck13VrGokvY2h0b9NJjR5BGVHfx+UZEsRm7IIkbVPjTkIQGfZa1MeDuM5hiJAoa6yptIlLYLryIvGxhPVEhhQMjO2F8QD0iE6PaCb02tETIx3U+qVczaKK4GfvuYAeEoDRHZaibYE1LGBeQWUvt5PRTKvdN8lEcFUtCMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158584; c=relaxed/simple;
	bh=XFBNQXNTRtq9lTUwNbPlFAX50TtpxG00+ejLAX5wSnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPtQDPOXqUIuXEJSF3Fu6C8oMxyiin+zPdEckIG30vXem8pF29/RZ+dxzSnw1yq9qtdVVjKrhJZxl4COqQBN+v4s2i4iUlg7O4bmfd8KNiPUF7CkxKFr2rryJPvk/1QupwpveqOFhDe3TjhtQhPm56CofL87fpSClqX2Vq+LkCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVMDhzFK; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVMDhzFK"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so240819766b.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 19:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779158581; cv=none;
        d=google.com; s=arc-20240605;
        b=JGXFvtGHn8sU7h9CwGTqy5fgZpRAwR8XmmKNcMxV7+qMP9+jskefHE8Zbo4fNfbtY7
         FduQRTPPRPP9NRBTmNYG0CcOMeg9EIdeaIkg31ECaAp5AL1KRFVn0DQwgg3VIiZanMhr
         8Q2FAFMZKwBNPQmbGkCrSXkg4FSS2oGUhcakyDIRHQT/OjXo57h1YVi/fJgg1HE2Qp0N
         2DdPtxURdBlhPVIDmxX6bvJxa4bZE2SQeQM8/CimV1NUrCfOh75aDhLJ9yclaDkR9OjV
         lITNh8LfjsXx9bI8712WwX/3l9ZfXDmlwed93uZJy+vtKXRDXgcPIlTOilUPdmmxEUW0
         3u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MZ+SEcsTYneCutuxXruVx/QbfBUaQaLGgsCioCoYxmc=;
        fh=36DccDK5KBEBDENUBsx81tl+aR09HUwPmchJAmLtH6s=;
        b=Ga8MC800N+3s15gg/N02catCJIsIRDKm/Jvz6YpRRUAXii6GbrB7WWgQDpNggXSRLV
         2oT2e+TwmiA+SD6vo7yoPDZ0V1kCHLR7kXo/hiT6k2i70mT8Gif5sSAI8xY6054QOMRY
         FHqkG9ihGgMeikmD2EqtmOGRuu38vNz7wcUeHp97rBQySxCrw+dx4O7Npi2oXRmPy3Q3
         o59BL8rVzI1uyhq44DvDkWiWaBs6fGEQ2Z5BJt/z9OZaT5u29oatmcUYPbAxFqkuzRYW
         KsPPjKIp/HGHv348yyMnpQwB2V5Jq72AowdEoeiLhGcTUF7J2GH4/zzx/fdLTFkEVkIk
         2SUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779158581; x=1779763381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ+SEcsTYneCutuxXruVx/QbfBUaQaLGgsCioCoYxmc=;
        b=FVMDhzFKDCebZsenuE2cVcA3j2LdkmDNnlE+aLIb9B6gCaDeWkC8MBW0FPZoVGjmUq
         Zts9MxEclXNR4T/X9HwUyFlO4zbXttl79Z7i/ixjQP9U4GSBB+Y5qjUmj3GwTrMd3hDu
         PXVP71YoPBrYdlTe2l9bygDugrQTSHn1IlqcmgGYciSlLl5J1Fz2TZygU9NxRO//xxsl
         m4NCD/23cTJcp6GF4Se1GSLlZ/Imm3PM+aZfuTaky7+4t9CjSdKRyV42/6YdF5DQziRe
         EA26NLx/Q+lPxulJg0/MsT4cGxq8USb7Qe6ExIrXk7lYTEv8nk2N5xYo/Y+yOP5s7MrK
         ohmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779158581; x=1779763381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZ+SEcsTYneCutuxXruVx/QbfBUaQaLGgsCioCoYxmc=;
        b=ZmMKXzgDPKZU1AjlxLr0EZqbIId1azdJmy1D89KCQks3Ef73oU6LaMilTXzMayPsHY
         eE8a2BCpvMi4d+0Nhyy0OZPeQKQpJXR0ZH1jcaTtMs3tWtAjuF5f5dkLVKnuWeJY1HEo
         J1/uVNIDhpMXU/t0a1h9+f88JhUdSsK2ua7vniSg/AepCOuCoKkTZ5scs46OP6Parvu0
         /peVTsDfHrAdMXapndH+cww8/4EVDl7XmEMWgzHu90aLeW2xPLROHyvnZKlpkqmLo4K3
         6Y2e9FjSlFp1KBB6YoleCZ/duWbG1v/V5GuDl0T7XJMLx8O+66K6cDQnw2Su8vHV+GME
         9zNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9khkOkcX00Oo0MW/PtQioDQaV5rWaaHWJ2vQj3KOqCHvDIZbG/6Ry8K2SxCyoDmmxcRcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VBYa6tB7oZcrhs6AQdWuzE47hWO+dwZhhZJwbU9ERxpTkWAP
	7hfJ3G2h2kU7wLUtTxWHfuTvFooj0Yc+gGtuGTv7MpmQLqY6h0avjaVnpRiH25NRmzIcc6NrRNJ
	qHJ6MLigu7EARD1ROSUGm/4p/VTJAwas=
X-Gm-Gg: Acq92OE4+DsX3codyY9+x4WmeLi4PKfFqwJ9mc8eigq3XJ3cX2jmn81lHTeifai9reP
	65RSVjcDaV9gTeuZVz//w2Aur8oDLVEg5GABY7zYCzHQourNg2VGEigYXEi009wDgbYMuL29T9S
	Ds6pMDh+bdweRh546Z/oBPBEXwAAty9ja3MZejV75277p3yQQqEzKPoUOvh8UPkjS6lq+nWEfqS
	cYqevq/nwm1QqkhUZADdaztx6RpO1DYRVRHHwWvdJ7PZnpR81lJ0o1W/cecgRETXwK1stJiKkLF
	875Xt58gpb2TlgOXv3PxLjJZ1Ctn4O02U6w+zMI=
X-Received: by 2002:a17:907:3e83:b0:ba8:e7b5:39ad with SMTP id
 a640c23a62f3a-bd5170a63b4mr956682966b.0.1779158581089; Mon, 18 May 2026
 19:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_bE8J7+=5ucBxpYubj5V_WdB9UuuzR1riyFr4FyGZfzz61gA@mail.gmail.com>
 <CAL_bE8LYJHGBt4JWzxWpFG+dC4ukTOwF=xB-r_R+ASE1v5Q+7g@mail.gmail.com>
In-Reply-To: <CAL_bE8LYJHGBt4JWzxWpFG+dC4ukTOwF=xB-r_R+ASE1v5Q+7g@mail.gmail.com>
From: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Date: Tue, 19 May 2026 10:42:50 +0800
X-Gm-Features: AVHnY4KKvAaf_kaRPnNyfMMdW0Vl-EAnBg7JsmvwT_bRLSElfAlc8D7dWbNvS_s
Message-ID: <CAL_bE8+yZ_5SB+SoLt9L=EX8ZA0oT-PpYpLSxJbGHRrh-OtF+Q@mail.gmail.com>
Subject: Re: [SECURITY] bpf, sockmap/kTLS: sk_msg sg.copy desync exposes
 splice-backed file pages to SK_MSG writes
To: Security Officers <security@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E9=92=B1=E4=B8=80=E9=93=AD <yimingqian591@gmail.com>

09:29 (1=E5=B0=8F=E6=97=B6=E5=89=8D)
=E5=8F=91=E9=80=81=E8=87=B3 Security=EF=BC=8C Martin=EF=BC=8C David=EF=BC=
=8C Eric=EF=BC=8C Jakub=EF=BC=8C Paolo=EF=BC=8C John=EF=BC=8C Jakub=EF=BC=
=8C Alexei=EF=BC=8C
Daniel=EF=BC=8C Andrii=EF=BC=8C Sabrina
Hello, I reported this vulnerability on May 11th. Later, I discovered
that other security personnel also reported it between May 15th and
17th, and it seems the developers are preparing to release their
patch: https://lore.kernel.org/all/rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroo=
peohspfnyv@7ryrgezzs63q/.
However, I haven't received any response. I'd like to ask if, if it's
the same vulnerability, could I be listed as a reporter?

Reported by: Yiming Qian <yimingqian591@gmail.com>

Thanks,
Yiming Qian

=E9=92=B1=E4=B8=80=E9=93=AD <yimingqian591@gmail.com> =E4=BA=8E2026=E5=B9=
=B45=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C 09:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello, I reported this vulnerability on May 11th. Later, I discovered
> that other security personnel also reported it between May 15th and
> 17th, and it seems the developers are preparing to release their
> patch: https://lore.kernel.org/all/rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggr=
oopeohspfnyv@7ryrgezzs63q/.
> However, I haven't received any response. I'd like to ask if, if it's
> the same vulnerability, could I be listed as a reporter?
>
> Reported by: Yiming Qian <yimingqian591@gmail.com>
>
> Thanks,
> Yiming Qian
>
> =E9=92=B1=E4=B8=80=E9=93=AD <yimingqian591@gmail.com> =E4=BA=8E2026=E5=B9=
=B45=E6=9C=8811=E6=97=A5=E5=91=A8=E4=B8=80 10:50=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hello,
> >
> > I would like to report a security issue in the BPF sockmap/SK_MSG path
> > when it is used together with kTLS splice sends. Please keep this
> > report private for now. I am not Cc'ing public lists.
> >
> > A BPF user able to load and attach a BPF_PROG_TYPE_SK_MSG program and
> > use sockmap/kTLS can desynchronise struct sk_msg scatterlist entries
> > from their sg.copy metadata. After that,
> > sk_msg_compute_data_pointers() exposes a splice-backed page-cache page
> > as writable ctx->data to the SK_MSG program. The reproducer
> > demonstrates modifying a root-created mode 0444 file page after the
> > process drops to uid 1000 and only opens the file read-only.
> >
> > Tested version
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Reproduced in a KASAN-enabled QEMU VM on upstream Linux:
> >
> >   commit 1bfaee9d3351b9b32a99766bbfb1f5baed60ddef
> >   Merge tag 'fsverity-for-linus' of
> > git://git.kernel.org/pub/scm/fs/fsverity/linux
> >
> > The local artifacts are:
> >
> >   poc.c
> >   kasan.config
> >   kasan-log.txt
> >   kernel-version.txt
> >
> > Impact
> > =3D=3D=3D=3D=3D=3D
> >
> > The issue allows a privileged BPF/sockmap user to write into
> > splice-backed page-cache pages through SK_MSG direct packet writes,
> > despite the source file being opened O_RDONLY and having read-only
> > file permissions. In the reproducer the target file is created by root
> > with mode 0444, then the PoC drops to uid/gid 1000 while retaining
> > CAP_BPF, CAP_NET_ADMIN, and CAP_PERFMON for the BPF/sockmap/kTLS path.
> > The first four bytes in the file page change from "ORIG" to "PWN!".
> >
> > This is not a KASAN-invalid-address memory bug: the write lands in a
> > valid page-cache mapping, so KASAN does not emit an out-of-bounds or
> > use-after-free report. The VM was nevertheless built with the attached
> > KASAN config, and the attached log shows the dynamic page-cache
> > corruption result.
> >
> > Relevant code
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The important state is that struct sk_msg stores SG entries in
> > msg->sg.data[] and the corresponding copy-only state in msg->sg.copy.
> > A set copy bit prevents sk_msg_compute_data_pointers() from exposing
> > the SG entry as directly writable BPF data.
> >
> > Relevant locations in the tested tree:
> >
> >   include/linux/skmsg.h:245
> >     sk_msg_compute_data_pointers() checks msg->sg.copy[msg->sg.start].
> > If the bit is clear, it sets msg->data =3D sg_virt(sge).
> >
> >   include/linux/skmsg.h:258
> >     sk_msg_page_add() appends a page-backed SG entry and sets
> > msg->sg.copy[msg->sg.end]. This is used for splice-backed data.
> >
> >   net/tls/tls_sw.c:995
> >     tls_sw_sendmsg_splice() imports pages from MSG_SPLICE_PAGES into
> > the kTLS plaintext sk_msg via sk_msg_page_add().
> >
> >   net/core/filter.c:2788
> >     bpf_msg_push_data() shifts msg->sg.data[] entries to insert a
> > newly allocated private page, but it does not shift the corresponding
> > msg->sg.copy bits. It only clears the bit for the new private page.
> >
> >   net/core/filter.c:2937
> >     sk_msg_shift_left() shifts msg->sg.data[] left when
> > bpf_msg_pop_data() removes an SG entry, but it does not shift
> > msg->sg.copy.
> >
> >   net/core/filter.c:2952
> >     sk_msg_shift_right() shifts msg->sg.data[] right without shifting
> > msg->sg.copy.
> >
> > Root cause
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Minimal failing state:
> >
> >   1. kTLS splice send creates a one-entry plaintext sk_msg:
> >
> >        data[0] =3D file_page
> >        copy[0] =3D 1
> >
> >      Because copy[0] is set, BPF direct writes should not be allowed
> > to this entry.
> >
> >   2. The SK_MSG verdict program calls:
> >
> >        bpf_msg_push_data(msg, 0, 1, 0)
> >
> >      This inserts a newly allocated private 1-byte page at the start
> > and shifts the original file-page SG entry from data[0] to data[1].
> > The copy bit for the original SG entry is not shifted to copy[1].
> > bpf_msg_push_data() clears copy[0] for the newly allocated private
> > page.
> >
> >   3. The same SK_MSG program calls:
> >
> >        bpf_msg_pop_data(msg, 0, 1, 0)
> >
> >      This removes the private page. sk_msg_shift_left() moves the
> > original file-page SG entry back from data[1] to data[0], but the copy
> > bit is not restored. The file-page entry now sits at data[0] with
> > copy[0] clear.
> >
> >   4. sk_msg_compute_data_pointers() trusts the now-clear copy[0] bit
> > and exposes:
> >
> >        ctx->data =3D sg_virt(file_page)
> >
> >   5. The BPF program performs a direct write:
> >
> >        *(u32 *)data =3D 0x214e5750; /* "PWN!" */
> >
> >      This modifies the original page-cache page.
> >
> > Dynamic evidence
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The relevant output from the attached VM run is:
> >
> >   [init] skmsg copy-bit splice page PoC
> >   [+] running as uid=3D1000 euid=3D1000 with CAP_BPF|CAP_NET_ADMIN|CAP_=
PERFMON
> >   [before] first bytes: 4f 52 49 47 41 41 41 41 41 41 41 41 41 41 41
> > 41  | ORIGAAAAAAAAAAAA
> >   [+] loaded sk_msg prog=3D3 sockmap=3D4
> >   [+] tcp client fd 6 inserted into sockmap
> >   [+] ktls enabled on sockmap socket
> >   [drain] recv 4 bytes
> >   [after] first bytes: 50 57 4e 21 41 41 41 41 41 41 41 41 41 41 41 41
> >  | PWN!AAAAAAAAAAAA
> >   [RESULT] FILE_PAGE_MODIFIED
> >
> > The PoC flow is:
> >
> >   1. create a root-owned target file with mode 0444 and contents
> > beginning with "ORIG";
> >   2. bring up loopback and create a connected TCP pair;
> >   3. drop to uid/gid 1000 while retaining CAP_BPF, CAP_NET_ADMIN, and
> > CAP_PERFMON;
> >   4. load a BPF_PROG_TYPE_SK_MSG verdict program that executes
> > push_data(0,1), pop_data(0,1), then writes "PWN!" to ctx->data if data
> > is non-NULL;
> >   5. attach the program to a BPF_MAP_TYPE_SOCKMAP;
> >   6. enable kTLS on the sockmap socket;
> >   7. splice four bytes from the read-only target file into the kTLS
> > sockmap socket;
> >   8. read the peer to drain the record;
> >   9. reopen/read the target file read-only and observe the page
> > changed from "ORIG" to "PWN!".
> >
> > Relationship to known issues
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > I checked local records and public search terms for the key functions
> > and state involved here, including:
> >
> >   sk_msg_compute_data_pointers
> >   sk_msg_page_add
> >   msg->sg.copy
> >   bpf_msg_push_data
> >   bpf_msg_pop_data
> >   sk_msg_shift_left
> >   sk_msg_shift_right
> >   tls_sw_sendmsg_splice
> >   splice-backed sk_msg
> >
> > I found known bpf_msg_pop_data() fixes such as CVE-2024-56720, but
> > that issue concerns different state handling around page references,
> > zero-length handling, whole-message pop, and iterator/value bugs. I
> > did not find a public report or patch covering this sg.copy metadata
> > desynchronisation with splice-backed page-cache corruption. The
> > reproducer still works on the upstream commit listed above.
> >
> > Reproduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The attached poc.c is self-contained and avoids tc/ip. It uses native
> > bpf(), socket, kTLS, and splice syscalls.
> >
> > Example commands used in my VM harness:
> >
> >   gcc -fno-stack-protector -o test poc.c --static -masm=3Dintel
> >   # pack test into the supplied initramfs/rootfs and boot the KASAN
> > kernel in QEMU
> >
> > Please let me know if you want me to test a proposed patch or run the
> > reproducer on additional stable/LTS trees.
> >
> > Thanks,
> > Yiming Qian
