Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA63BE16A
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049587; cv=none; b=ZhFiVIvqSTL3PyCu0oZEvBO2PEOb+Rsgjpk9lccN62oLZy8k06mxSU+j5OUnBJhDG2vM0CsOT44QbYV/IWEt/eqEgu6ozQ8vdfRburcJMQ56BCT6vSF31JZF7QOTI+VYzuT7qL+CicASwOtoGSlJGIir6Tjc8b4PJrkp6WqJFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049587; c=relaxed/simple;
	bh=dwQaRZW2snGfE5QTHgssjJNWgEQbDL/7M0WsCflFpR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y498h6voBvASlaZSL8ZWcjs2cwBw33XTq1eu/UfaBFAGCMVvL2EPKBlNqH/hMIBo6bUnY+xALGyZlVM8D2t4KXYM4iN0pTJ9+t+/3krISDQlwP1NA7yLRIvpb4BG7fQlcSPUAiyqqyHZ6fHQM/SH6luUAN5/0Vot+lqP0KFJRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1rpYujd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1rpYujd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB781F000E9;
	Tue, 18 Aug 2026 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787049586;
	bh=60B3+HyETO8MuENIGpziXpb5YOwGi1P1sRgHpMroKOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1rpYujdu5aYr+pnI7EKilsmkyV/m4b9otZc748sFtzQnBsuFN1Pa5eQ1av/DrBAm
	 ajnNc4Vkk3cTo3T98gkJN7lUlc7cqha3iRshn/S6+wgrFjPwPpl93FHiPit7HQTWyN
	 madd60EKdsV5LeKL6/fTOm9o7lSCVqJIT2AHwUl2qef0Y4AEiHz/UkRzrenq7AQqxH
	 5a1OfJ5Be7P7kirqXBgRJiMcN9U0UexvekZSUc5AlCPk7Cwj/HsidXWLX0TJ6aPYxn
	 aIi6u5tYwpA7lNvpDNoZNJ+gZbRqX8ZQx+5aDnbPLuiy3zuijB0bHsfajXU+jOrxO1
	 cJnPuZPjbTG7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] smb: prevent TIF_NOTIFY_SIGNAL from interrupting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818-work-tif_notify_signal-v1-4-1ee1fcc5b3ff@kernel.org>
References: <20260818-work-tif_notify_signal-v1-0-1ee1fcc5b3ff@kernel.org>
 <20260818-work-tif_notify_signal-v1-4-1ee1fcc5b3ff@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:39:46 +0000
Message-Id: <20260818103946.5AB781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Partial send of the RFC1002 marker is not accounted for in `total_=
len` on error, leading to missed connection teardown and TCP stream corrupt=
ion.
--

--- Patch [4]: [PATCH 4/4] smb: prevent TIF_NOTIFY_SIGNAL from interrupting=
 ---
commit 0a99d5c0436dadc5ec220717067bbc5bd7313e1f
Author: Christian Brauner <brauner@kernel.org>
smb: prevent TIF_NOTIFY_SIGNAL from interrupting

This commit replaces a hand-rolled signal masking solution in
smb_send_kvec() with the new no_notify_signal_save() critical section
to prevent io_uring from cancelling a send in flight.

> diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
> index fdf4e50c27ceb..05dc20916c276 100644
> --- a/fs/smb/client/transport.c
> +++ b/fs/smb/client/transport.c

[ ... ]

> @@ -172,15 +172,12 @@ smb_send_kvec(struct TCP_Server_Info *server, struc=
t msghdr *smb_msg,
>  		 * after the retries we will kill the socket and
>  		 * reconnect which may clear the network problem.
>  		 *
> -		 * Even if regular signals are masked, EINTR might be
> -		 * propagated from sk_stream_wait_memory() to here when
> -		 * TIF_NOTIFY_SIGNAL is used for task work. For example,
> -		 * certain io_uring completions will use that. Treat
> -		 * having EINTR with pending task work the same as EAGAIN
> -		 * to avoid unnecessary reconnects.
> +		 * Task work must not abort the send, see signal_pending().
>  		 */
> +		notify_flags =3D no_notify_signal_save();
>  		rc =3D sock_sendmsg(ssocket, smb_msg);
> -		if (rc =3D=3D -EAGAIN || unlikely(rc =3D=3D -EINTR && task_work_pendin=
g(current))) {
> +		no_notify_signal_restore(notify_flags);
> +		if (rc =3D=3D -EAGAIN) {

[Severity: High]
This is a pre-existing issue, but does returning -EAGAIN here cause a
protocol desync if we partially sent the RFC1002 marker?

Looking at __smb_send_rqst() which calls smb_send_kvec() to send the
4-byte marker:

fs/smb/client/transport.c:__smb_send_rqst() {
        ...
        rc =3D smb_send_kvec(server, &smb_msg, &sent);
        if (rc < 0)
                goto unmask;

        total_len +=3D sent;
        ...
}

If smb_send_kvec() successfully sends 1 to 3 bytes of the marker, but
then blocks and eventually returns -EAGAIN due to the 15-second retry
timeout, the code jumps to unmask without updating total_len.

Later in the function, the reconnect logic checks total_len:

fs/smb/client/transport.c:__smb_send_rqst() {
        ...
        if ((total_len > 0) && (total_len !=3D send_length)) {
                cifs_dbg(FYI, "partial send (wanted=3D%u sent=3D%zu): termi=
nating session\n",
                         send_length, total_len);
                cifs_signal_cifsd_for_reconnect(server, false);
                ...
        }
}

Since total_len remains 0, this check fails and the connection is not
terminated. Will this leave stray bytes in the TCP stream and cause the
server to misinterpret all subsequent requests?

>  			retries++;
>  			if (retries >=3D 14 ||
>  			    (!server->noblocksnd && (retries > 2))) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-work-tif_n=
otify_signal-v1-0-1ee1fcc5b3ff@kernel.org?part=3D4
