Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827614;
	b=Y59ORMvAOJqzJrw5wWWTe0Fb8Er+IxqVwvhTeZnWwJ3KyVO5guRhT8dbhnPrKepv8VEJ
	 aQw9NE6DBcGBE13XjjIxP6f59x5j73DW+7s7wbmnrDb8hl1Yg3Hpj1CuG09AT/eow08ks
	 W0IKu7taMGonpgz9apNdXle/bxGX72f7l7g2UZDyftNmZB/XbEFWVz/3fzOzC06az4YVa
	 JGFSywaAIvW2L7aeifAdpzPinYGcefYevgPqLo3k0h6ejH7kS5jJlv2b7WPS3wY5VsM05
	 qDFoTqEW8eFkeHce2DRbN0sECinNmCzqoKkz2N5DG2XBkJjoDJDTmaetUQMgC6sWHig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=Fx8mwjCrbZCWbiZSWWBXN0aiI/C9oFeig/QmjdPJVek=;
	b=qgzzZLYX7YxBt93qqGAyAXtF/AFTekrzwcUsiYtp+gnjMvg5gRpgNWNqGbyhTUjV4hSw
	 bYymqRheF78RAsUxAcQsKS3ODvgnedNgrFFlj6jEKShRD93sa0mGnnNb6ZgLVTbWpZKFW
	 lsnUE92X/RBv5XhMUqpLQ7Pxb81H3tYKMsimY3aIXI7nnLJ8QLfN9GvF/YImveGgdM3m6
	 8/FsrcPQRG0iNw14l4//wnhDiEm/2jUrgxNtg3WRMsZ2wNjZcgF2b5fEs24MIYP96IG22
	 yEmlyFxH/EOz7NchCHPyDlQRAgGR+JzuRmrnwPg3iX08r9/NnUSkhSdGsv8H0liR0eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vy+SWiVb;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A822606BA2C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A822606BA2C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vy+SWiVb
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-536c8f958d7so9079761cf.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793827612; x=1794432412; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fx8mwjCrbZCWbiZSWWBXN0aiI/C9oFeig/QmjdPJVek=;
        b=Vy+SWiVb/NpXstpdw56lw+criQ5VLmL5fI7nn0T68KlPT3t+Dt/ZXXIrVA+Cb9oTH4
         TPCa6A3seRH9NuwzLYB4U8f/OShYV6IlQIso/owGoN/zGKf8RjT/HHAYQiFq6Md9/AGx
         OQu+WfEphT/kKjXP8GvKBBFJyiAVMrQefdiWdJmUUcdvKTLoDsWtPAZotnQX9UJOrzaQ
         xRONIbMdbEwkr1WI3Kg4PeBEsFZ5Y37wda519hWTRbTA9zS4VszXsqzBXwuK7HvvH0Qa
         FvCJLDSn4KAlIWnCl9a6eAaYBJKX17NVHsnq7L+bnHg+v812XRAWefqQg5U2r0LgvExP
         /fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793827612; x=1794432412;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fx8mwjCrbZCWbiZSWWBXN0aiI/C9oFeig/QmjdPJVek=;
        b=J54Sz0ALPBFDy1F7woDeZgE4DMUM/cpg3WGRerYRI9VOsj/nwewYKUMxYj6RMRyqkj
         kJvcEmxgupOJZVNAwEDZgkw7CRVNe0hhWxoKYh2ruKJP3CDPaf1Vnn9AYkTSyWKaT/67
         9N019KyuVzHvXOlIkdg9igqZJvkIYZouZzYMLcQ+aYvvPTkK+sl1saQUeAlygo19o9k8
         gKT6JyevjCuJ13uHle9mL7kIPrUtDGc7VoDszqtm6RWkmxNdiTTCdgyPWdrcxuN9BcQI
         tzY7PIBMErVGrQqgV1mniXevvBCN6QwjkzKm87vJSR0MPZ7+Euk56pQcGu6WgerdE8rO
         iDdQ==
X-Forwarded-Encrypted: i=1; AKwUvByM/4ntdWp7cp6O1/SeFiGJpXGgz06AvPkGcwbkxFKMivIp8xnUqb9bBO0m6P3EwWPNRVk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2YTMfSC8B2UYWBnSpkO5l03zrS3ECOqqbxY7BxoMENOsIqSMT
	D1iM0b+xEZnnOqtESQuHzkm08VeFYsRhKQZ6ZRT7hfmnHFM7vNYMFVel
X-Gm-Gg: AYBFou1WpEeM9h9HdB2Ko8Yf9HABy+7vm7cT16zT16cgWg7DYXz71NlF5RCdc91RA3M
	U2sfXad+AQsGZ/9bR6fGj9Yps1rmmJOUC3r03fC0RI/A9TRFfVYudIgHT62QvshKAopbiAGLWl0
	JGHlXwE8kFlMjUojzcJIOoXwHzUL7zDnOJUIcJwZdvKLfFmIKzIQ1QB0bWY1V49vWd6jFRoh3AA
	xUV5Aojoz9Xj3mR3oi48OcvI9NMHhpshiQB03bvXVRFkL+re9NvKkaZTzC4XWUdFu35W8NUbyiN
	0S7ME82LEAsEDjUEaF2GXEHqwO62KaU2YULQWfl/bhm56227ijoYPv3zkG5Q7x7SDKnPKQPooLe
	IwGTlr+sDnmKvuZMT9PZTNG5SxXZlp5igaT7UypLTBb8/Y0RMPH8X5ibKJvMX+TD1N3ODFqEpzY
	V/v3XvcgeJQ+uzXsqel5SkIzWkoW+gezIfr2Ua8FV6cId7p36C37MHfy/0+OlFG97NCsUocRNEG
	uQwQFMYqugdJ6T6q50WPAfhvGfMTl4bhl5xb93f0egE9Ilhtl6WibnuFAJtRuAmnGFFhBFEWAwO
	hBmDlUs6fPWPH8o8
X-Received: by 2002:a05:622a:2510:b0:533:8bf0:e6 with SMTP id d75a77b69052e-542b6a703c1mr284677281cf.35.1793827611998;
        Wed, 04 Nov 2026 13:26:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::4:a8c5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm34508841cf.20.2026.11.04.13.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 13:26:51 -0800 (PST)
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
Date: Wed, 04 Nov 2026 16:26:50 -0500
Message-Id: <DMMQTFS3ULM2.3HSJGB1UT085M@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] selftests/net: psp: test bidirectional data
 transfer
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Wei Wang" <weiwan@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261030043145.2185700-1-weiwan@google.com>
 <20261030043145.2185700-3-weiwan@google.com>
In-Reply-To: <20261030043145.2185700-3-weiwan@google.com>

On Fri Oct 30, 2026 at 12:31 AM EDT, Wei Wang wrote:
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
> ---
>  tools/testing/selftests/drivers/net/psp.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
> index 473500901879..e507951b440b 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -120,6 +120,12 @@ def _check_data_rx(cfg, exp_len):
>      ksft_eq(read_len, exp_len)
> =20
> =20
> +def _check_data_echo(cfg, s):
> +    _send_with_ack(cfg, b'data echo\0')
> +    s.settimeout(1.0)

I'm not a huge fan of setting the blocking timeout here. If we are going
to set a timeout it should be when the socket is created. Otherwise this
function has an unexpected side-effect. Another option is to use non
blocking reads with timeout like:

def _recv_careful(s, target, timeout=3D2):
    """Read exactly target bytes, tolerating short reads"""
    data =3D b''
    end =3D time.monotonic() + timeout
    while time.monotonic() < end:
        try:
            data +=3D s.recv(target - len(data), socket.MSG_DONTWAIT)
            if len(data) =3D=3D target:
                return data
        except BlockingIOError:
            time.sleep(0.001)
    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")


def _req_echo(cfg, s):
    """Ask the peer to echo, and check the reply arrives intact"""
    _send_with_ack(cfg, b'data echo\0')
    ksft_eq(_recv_careful(s, 5), b'echo\0')

> +    ksft_eq(s.recv(5), b'echo\0')
> +
> +
>  def _check_data_outq(s, exp_len, force_wait=3DFalse):
>      outq =3D 0
>      for _ in range(10):
> @@ -478,6 +484,7 @@ def _data_basic_send(cfg, version, ipver):
> =20
>      data_len =3D _send_careful(cfg, s, 100)
>      _check_data_rx(cfg, data_len)
> +    _check_data_echo(cfg, s)
>      _close_psp_conn(cfg, s)
> =20
> =20
> @@ -726,6 +733,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, i=
pver):
> =20
>          data_len =3D _send_careful(cfg, sock, 100)
>          _check_data_rx(cfg, data_len)
> +        _check_data_echo(cfg, sock)
>          _close_psp_conn(cfg, sock)
> =20
> =20

I'm ok with the approach overall. The coverage is sufficient for the
purposes of the series.
