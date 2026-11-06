Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990076;
	b=oSBqLF2XunAk9GSxl92yR5QhzYMCm85ZxF9hHJelGiSHsqw6NmkXvH0eqHgQZ3fo8VMS
	 EeDyhq8XHdWLFuC88F+072aPGdIX5Ed4t8K4ExCo82jA37zcNcs2A31/pI9hZjcgsn4QY
	 IoPhrg2firuSGtRQKanS1JRTood5MJRcoflIiek+ZRZL2PWxwe2h6DTm+ZSa7vcxDMykt
	 1I4dcFvHwKqKjR2zfB8bPyXGCTuIxPmUhXsfyQ5gEGVIaJyavLAE9l5SWPkFvQtb5/XW+
	 kZzEVYXTEIItKGRhBNpdw37Jkpv/sHFnACYAPEjRu07KYLPPtY8SBHcV9WLX4vUjq1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=+c0xWdkkcKoTE4Rdj27Yc3MLhE6rmfRXOfJT2CGVuAQ=;
	b=PBEeBoT4ElDbIC1StPYo64uSnAYMnuwpnOoHaC47fqQ2QL/jITlbJyswB/qeFFMzxWi0
	 O0D6jHFIc5NTJ4Ipg+T++cZdGMZCPs5TDmHTZ6wjuJnGtNSqU/2V4ZT58GN51JRTSkaZ/
	 fOSnS/8leqd2+jeRJXauaLmynysh3jPYQWD1RyUnDvNE6fbBxir3U537jENmehR8ioiDq
	 Gau1bNoU5vjnzufQsJi2S/1UKsc9Q1wLV45WewsnhdIFGcMGhQgc33W1pWGfWdFyBtAMe
	 MHdFuWzQPGO6Io2xaFyh4RpTjnYhiIJAirklf/uUopzJPAwD1jUNQSpDxK2AD3Uv/5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=azEJaddf;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D34606A338
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 18:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D34606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=azEJaddf
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ea5600c9cso12444936d6.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990075; x=1794594875; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+c0xWdkkcKoTE4Rdj27Yc3MLhE6rmfRXOfJT2CGVuAQ=;
        b=azEJaddfPLszRG2YEd8X8XX3QNSmADkhMqqQkz8WJCqDHCX/yElegKK2JUmNUFCVFn
         1m9uk2k/p4dq4w3fJAA/u/LJ3eU7HusdduRCkLAdoeLqlRTmain3Uqa0I68B02+FRZjN
         iz+KKvNA8NWhZE+WAdsdD77VmTCugNNKnPrerZfcB2h7EcelHiX5fEb4Rx1oJuYFUAkl
         nqZXZGuHeNLKXtxcXQ2MZVRcRDisv+8FiLqCpkzml5h6bYhW6O6CeuCKbMBPGtv4XmJK
         Bp4PO2afCpZFU6DuKRKSo4n/5AT3FCs/rRv0Vms0kdAB3NGupdnhqglYZoGMUaE+OrJ4
         yZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990075; x=1794594875;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+c0xWdkkcKoTE4Rdj27Yc3MLhE6rmfRXOfJT2CGVuAQ=;
        b=faIgaN5wuxCfUxPFPjEDiztef449f591ydAp2/bViIDIHsJOVPql+FqcOSzV5zlT6P
         uI+jWZBJS1LYmYTqtr5JyaITBt0INIV2Eb5LsB8DfJmctaZ6oAbbexX1tTiGPDLryuky
         OIIvEtS+OD6bunorZmc5bFChFP+jnDNWeOX19wQQOE8Pgee1/v8NJd/08+RD23vogOBj
         KJFP3DRWMq+I1zkwxBFPaBT+212XGyA6SGqetOUvw0BdSscxcnXNyIaF8sfOaggBLlg0
         Xryux6EeUXuqb+8K4hHWSN/UNbg0N2zNpobNEg49zYnSWRyjaGi2BMDW4U5lfPJEt/qm
         um4Q==
X-Forwarded-Encrypted: i=1; AL+hErG8aH9V/IrNxaZZQITmUA6D8W7IE3Rw+E+gYUHMWZFD8hhUIp1GzH8lrKV/eCahA5vYnjY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dr+y8zQkdaW7jHkQ875AwI8U+Sjycnu4qOdzH+WR0ampjT65W
	w88n/qaungHc+zogwqgizMe7QTSW3sY2q7WjtSvm1pbd1+t899WiHmrc
X-Gm-Gg: AYBFou1q5dj5nph6G+IZWlRpH1mFH+fwLbcF4xpNT1DRTPagB0VV4nbu8dZEoUSTSfs
	X/M2A7bFLCBKd0BBE3RrrKJdA9NWZVIntW9UwvY4POd8ApDHSKBaPMiICwFoQx6SHQpuukyELc9
	gp8x9zYvqlEX8B8BUJCJ0Ax9rzjdHgpH2TclUCpiEyahfgQRK788filZt74aLNTpuKs8vOecYeG
	K1SDpYLxY0k103mCHSavIG+QKToq3znk01x6tshnm9U/MTZqIBEtB8LacHd+O4U/dGV96Al/maX
	iP2R8FSFpzX55iY3Pb+0uBhWCTdGdAZ0ui5bTFvaihKttsZsPTWxvt1o31GaVjaSrK/L8s6MGOx
	ENZRNvfizeBU5Wogxe46lKLq/eY2G/cEXY9cjBEgsgeXomZrMP/vi/pfkKnTdWJWXnq1npN6KT3
	dOG7/taSgzEzbMo2km9THlDL+NBTn9qqqJEipz2aybuHwbC2ljhTRVUkmqyylgzpNzNLv1uKFOl
	LMgyzVW02VcPg8wFQIwmIWIN0hc/pxmWEsSLUBTXO/YIaCx++Xn6x7OxcEokHcCaLzuQGxTTzAW
	zkY4NZIHCVnpy4olsQ==
X-Received: by 2002:ad4:4ee7:0:b0:91b:bcf5:a733 with SMTP id 6a1803df08f44-91ea9304f4amr50544826d6.2.1793990074822;
        Fri, 06 Nov 2026 10:34:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5:81c8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6900b00sm26542996d6.4.2026.11.06.10.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:34:34 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 13:34:33 -0500
Message-Id: <DMOCEM7IQVOS.I2QH7FT8FT8S@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] selftests/net: psp: test bidirectional data
 transfer
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Wei Wang" <weiwan@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261106182007.374660-1-weiwan@google.com>
 <20261106182007.374660-3-weiwan@google.com>
In-Reply-To: <20261106182007.374660-3-weiwan@google.com>

On Fri Nov 6, 2026 at 1:20 PM EST, Wei Wang wrote:
> _data_basic_send() and _data_basic_send_netkit_psp_assoc() currently
> only verify unidirectional data transmission from the test socket to
> psp_responder. As a result, they do not exercise the receive path for
> PSP-encrypted TCP data segments arriving at the test socket (such as
> packets redirected across a netkit interface associated via dev-assoc,
> which relies on SKB_EXT_PSP surviving packet scrubbing).
>
> Use the existing "data echo" command in psp_responder to verify that the
> test socket can also receive PSP-encrypted data from the peer in both
> _data_basic_send() and _data_basic_send_netkit_psp_assoc().
>
> Signed-off-by: Wei Wang <weiwan@google.com>

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

> ---
>  tools/testing/selftests/drivers/net/psp.py | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
> index 473500901879..c114d2245135 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -120,6 +120,26 @@ def _check_data_rx(cfg, exp_len):
>      ksft_eq(read_len, exp_len)
> =20
> =20
> +def _recv_careful(s, target, timeout=3D2):
> +    """Read exactly target bytes, tolerating short reads"""
> +    data =3D b''
> +    end =3D time.monotonic() + timeout
> +    while time.monotonic() < end:
> +        try:
> +            data +=3D s.recv(target - len(data), socket.MSG_DONTWAIT)
> +            if len(data) =3D=3D target:
> +                return data
> +        except BlockingIOError:
> +            time.sleep(0.001)
> +    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")
> +
> +
> +def _req_echo(cfg, s):
> +    """Ask the peer to echo, and check the reply arrives intact"""
> +    _send_with_ack(cfg, b'data echo\0')
> +    ksft_eq(_recv_careful(s, 5), b'echo\0')
> +
> +
>  def _check_data_outq(s, exp_len, force_wait=3DFalse):
>      outq =3D 0
>      for _ in range(10):
> @@ -478,6 +498,7 @@ def _data_basic_send(cfg, version, ipver):
> =20
>      data_len =3D _send_careful(cfg, s, 100)
>      _check_data_rx(cfg, data_len)
> +    _req_echo(cfg, s)
>      _close_psp_conn(cfg, s)
> =20
> =20
> @@ -726,6 +747,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, i=
pver):
> =20
>          data_len =3D _send_careful(cfg, sock, 100)
>          _check_data_rx(cfg, data_len)
> +        _req_echo(cfg, sock)
>          _close_psp_conn(cfg, sock)
> =20
> =20

