Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991482;
	b=osEyoZYlAADDoLmiuQ9M5r455B9NxwdpH8LOZqb5+x6Smpw2C2fPild6mxgJSXvjLn7y
	 GAKyzJnQ/jxIQaOkucVg9uGGaqwhZJWUqWQx1kOOjpQzp9tFd6aHuRHqpMPC1vqjCftmz
	 6bKxEIrzS03upnVZJWHuE7Q3rcPbQATOw3O37rswKE4EjV53ZdQWL5tSZTPcKuFDdp/5k
	 +4cIXeBBgG5eBmxSBrWoWVKv0eL0p9QuJ0uvDEBsL8vjN+aRakdXymzePYSzTPnmPKJpf
	 UwCYf+eJ1dI9yu6fMi2p21BTFm0SlHqBHGUfk6BOZPB6Ztd4v8z9kL+/0KwRUfc1+vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=/MMk4dpDTUnL+JeGvHAKWol8stlyFONQgS4qXzOKLhA=;
	b=aHwmzNKwgrdNAq/kstp2N5HLVLO/uxlXghTPKL30OrICBoTGDo7fOmSZuHn8SJa/Y5mk
	 KpuDTdsl+im5VC76Dudtc65k8S3NZR1XONHYnDBcKln83mdyd1AhQbdaX9ihF9DNYNRfq
	 zQ/x2AGzb7oD9Kq1HEknELofPU+JLvk1TZif3d1UDddo9gPPiQhfzNtcDAabYGW15iwhm
	 SQdK2A684M3FobUMu6LC+WY5RzuCyGIDncjkj+2RxPUMcMEvrCtbWjujsf1UkrgpXHTLp
	 l9Um4McqX5g8LzqxyTXoB5mxgIa5sszH76iKv387FhN/aUkLNWszorIYZlvxkcbi4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g2dlm1z7;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7E606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 18:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A7E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g2dlm1z7
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9440304604aso110692585a.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991481; x=1794596281; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/MMk4dpDTUnL+JeGvHAKWol8stlyFONQgS4qXzOKLhA=;
        b=g2dlm1z7R8dRmnPuJheXLtnTivnrhc+b2GrWjANEhjh9Ksp5Mr9TfeuOSWzqgp9kZz
         52cHo3yCTgNEqmD4dDy0mY7KMi64/zBtcjCerYQTcWedSg7ggnGF2oowk1AMZJIVRo6O
         2Qhg1pUHAtyWFMrib4mmJ0Mkc/RhcjTddE8NtA0q99cgq5Blq3A6oo2laEYQyKwNJUyQ
         547EOet4UgqoLGR7NjgVu7HEHpc0Vqp+tGr0lHMgrj9ndfUh0/BSEAQhHypbq3hvPcS6
         TWO0Lt6psS2GXpI9XZye69soOq9Nu9Y6Ywn/SQlSirhsK70U/sth30l7aamOOhDZga8+
         eE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991481; x=1794596281;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MMk4dpDTUnL+JeGvHAKWol8stlyFONQgS4qXzOKLhA=;
        b=XG1Qx659b3a9TbYvzHrr9M/ptBEQPM1SC4A3DGwgcb032NaqbB3nRrwkszgwTwnFQ9
         1LEMABcA6RPD8+VXKyKUfFUbkFjhjNV9YwzsFul99vh9qg6IwvodNJTVxf2o+1iY8D+y
         HbpydJLXvpB7SzI54gzWhCNGKajZVphJOs9nFdC39PlxRQ/rdhJc6VFme4wYFq+IAhyZ
         Dz2QpisUetR4lYtWOfptwbV4WoopV4TkpdI97CSZnsS6zzvFP/I8sRAN95L3lXkVZuvh
         z059hL6Dpr6AkMZmO+uJclcdmJHPiG2H/luDvVyhAaxWH+i0kcYxjJjBII0FIeZECKRr
         Geug==
X-Forwarded-Encrypted: i=1; AKwUvBw3ro9rQOB9ThCl0AaF7Y5gLyabDbuFSTvMJfuX6hcInS03VASB+Qh0TJalqCV5uonVbhM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uFybch7T9yMIDpazh2JkTXARUh/KGiGpAaeUIPc93rNWSEuee
	Xbd144GWu+gje2VK2EnXRDkiwycY6+W8JHQZbj9IFpEXqjAaWmsJDfyp
X-Gm-Gg: AYBFou1HTSG+DY0X4tNB+njcWFHhVdWbzZlAm3eOZyx83ujbQIa05cA9tu64qB/ZQGN
	VrL8lwtR14DDCeO77zjHePZcb6imMW9zKmOXp+XggO7tw5Rfjas7iaA5fdn7QHhxO+7FkW3nzXF
	EjC+xmaqrOX+uSkmGSeJBmc4Lfy01l4B8Mtb1ae3HGq1x0khYf6nZF9cjKWQeV/4nsjk9TKMyw7
	kk7j3HH/bX4qZgyhs59ROeeYq9+CruyEYDmHHZazSDongqQ4Kz+ZYEvu8A5S0P+u7Tgx7DRFKD1
	cgG7xXttjADLqwJo6dd7hQxr3arsr0h/ARdlCuh/xaRpyUA0BrsCCyz7Lib1ETCEuCyf/964EhT
	q871ut2gYDbQAhC5Nrj3n4+3IuxZLLowBVj9C6s9eWhSfsMDgzbL2e1YU+M9ujjEiGwhpqza/CZ
	vZJk2JTlZG1OOqr10cNJ9wNqjE+mwEqm1gxSa02tGIqJslYYOJlNvupoIEkSklxcNV0y1btQg4P
	FEwCbhUDtXiGZeP/upM2PyV53BO0qAkdgL8JskxOQhXsyUijfY83GFnxW51eosGb4w+0w/JHoKK
	Vty0+18jeqEyJbBIrsdXhlR9wpfg2Qe81cmsVQ==
X-Received: by 2002:a05:620a:45a6:b0:93f:59b8:e29d with SMTP id af79cd13be357-945f3512c78mr506798085a.26.1793991480829;
        Fri, 06 Nov 2026 10:58:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5:81c8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f599baa2sm207605985a.15.2026.11.06.10.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:57:59 -0800 (PST)
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
Date: Fri, 06 Nov 2026 13:57:58 -0500
Message-Id: <DMOCWJTNK6BR.3AS3IC9QSWXTE@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Willem de Bruijn" <willemb@google.com>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] selftests/net: psp: test bidirectional data
 transfer
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Daniel Zahka" <daniel.zahka@gmail.com>, "Wei Wang" <weiwan@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261106182007.374660-1-weiwan@google.com>
 <20261106182007.374660-3-weiwan@google.com>
 <DMOCEM7IQVOS.I2QH7FT8FT8S@gmail.com>
In-Reply-To: <DMOCEM7IQVOS.I2QH7FT8FT8S@gmail.com>

On Fri Nov 6, 2026 at 1:34 PM EST, Daniel Zahka wrote:
> On Fri Nov 6, 2026 at 1:20 PM EST, Wei Wang wrote:
>> _data_basic_send() and _data_basic_send_netkit_psp_assoc() currently
>> only verify unidirectional data transmission from the test socket to
>> psp_responder. As a result, they do not exercise the receive path for
>> PSP-encrypted TCP data segments arriving at the test socket (such as
>> packets redirected across a netkit interface associated via dev-assoc,
>> which relies on SKB_EXT_PSP surviving packet scrubbing).
>>
>> Use the existing "data echo" command in psp_responder to verify that the
>> test socket can also receive PSP-encrypted data from the peer in both
>> _data_basic_send() and _data_basic_send_netkit_psp_assoc().
>>
>> Signed-off-by: Wei Wang <weiwan@google.com>
>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
>
>> ---
>>  tools/testing/selftests/drivers/net/psp.py | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/=
selftests/drivers/net/psp.py
>> index 473500901879..c114d2245135 100755
>> --- a/tools/testing/selftests/drivers/net/psp.py
>> +++ b/tools/testing/selftests/drivers/net/psp.py
>> @@ -120,6 +120,26 @@ def _check_data_rx(cfg, exp_len):
>>      ksft_eq(read_len, exp_len)
>> =20
>> =20
>> +def _recv_careful(s, target, timeout=3D2):
>> +    """Read exactly target bytes, tolerating short reads"""
>> +    data =3D b''
>> +    end =3D time.monotonic() + timeout
>> +    while time.monotonic() < end:
>> +        try:
>> +            data +=3D s.recv(target - len(data), socket.MSG_DONTWAIT)
>> +            if len(data) =3D=3D target:
>> +                return data
>> +        except BlockingIOError:
>> +            time.sleep(0.001)
>> +    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")
>> +
>> +
>> +def _req_echo(cfg, s):
>> +    """Ask the peer to echo, and check the reply arrives intact"""
>> +    _send_with_ack(cfg, b'data echo\0')
>> +    ksft_eq(_recv_careful(s, 5), b'echo\0')
>> +
>> +
>>  def _check_data_outq(s, exp_len, force_wait=3DFalse):
>>      outq =3D 0
>>      for _ in range(10):
>> @@ -478,6 +498,7 @@ def _data_basic_send(cfg, version, ipver):
>> =20
>>      data_len =3D _send_careful(cfg, s, 100)
>>      _check_data_rx(cfg, data_len)
>> +    _req_echo(cfg, s)
>>      _close_psp_conn(cfg, s)
>> =20
>> =20
>> @@ -726,6 +747,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, =
ipver):
>> =20
>>          data_len =3D _send_careful(cfg, sock, 100)
>>          _check_data_rx(cfg, data_len)
>> +        _req_echo(cfg, sock)
>>          _close_psp_conn(cfg, sock)
>> =20
>> =20

It occurs to me now that we could have just changed the key exchange
protocol used here to have a psp encrypted "start of psp" message that
each side sends and blocks waiting to receive like psp.rst suggests. Not
worth respinning, but maybe a future cleanup worth doing.
