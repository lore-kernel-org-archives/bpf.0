Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4640DFB2
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777080345; cv=pass; b=CyLuiOaLQmTGv/Boz7/bQiikjwGOmNeP0spPLWKPcDOW6YiAnj7pvW0V9LKtHUK9yKFA8FYyt9RxHo8gatmn/zgO30JJYcGDexVv+uIVI+NoGWnpe0XA3ro3GbnbgPbRK0csMSU2XGZliBLyljqcT5Kxtw+NEwv+Yfuu548qvhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777080345; c=relaxed/simple;
	bh=f3WxHZbtknKcGnI7MqHVjqNi+RSh4xlbtwQn4qUCcbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db5ewJ9r9557qceGea9Viui7zx57Pqq4MwGdraSoEZ0MbZKpeQziKPVEUXanvJxcR737WcmdwTGIP76KI0lFC456XwmJ4/N0/vCamblJjfprGXZrXVQcNkBSlUf5lRHVxgkYXOqWPJDrXS86LmrKWoXgM2vwTrdboZWe5DuP3KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUX6m4h7; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUX6m4h7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so105215365e9.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777080343; cv=none;
        d=google.com; s=arc-20240605;
        b=kxnCUua94BsXUZZ39H922PdD3VI2JJWSKTxvsdkuXyv4PlLAQdkzv3T08WNoRxf5FT
         EHWC69ppn75iihzTxQ3FYZ26eI8n+LpGZ0aPdP9/C7sHwxuFLtGQjSQLiwmqv2MhuMQA
         /eUUbIXN4vAKGG+x5PrOepz99LKAv4OiqsYKlFOnPVlfV8wr8DOkLK0zqFNRkcX5nnPT
         T+8rPWcXt1d+OYVaOZAmoYk09e5vZggeLUpWpW8F+80LOvp+8l/Br0RzoRotxEvi4JIC
         XNYDy8GHX/VBwROpvwRJceTBS19IBkTwe/KjlmfqIpF3DKUsyD9CVrQuDwO838/qMMz+
         AS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ca/F5kJ24z9kaZckQtyAE58YWNbnN15FN51lqLQH+dg=;
        fh=sOVRhHpeoaPUQKXJmL0UK2Wa3I0KiptymUtIfjzqd04=;
        b=dGVAKY3FDtKtS78AvcjV2D4BClmfB8J1VHTUrbziAyFH5gGT32qcCowUSCZys+govI
         8lJpNIcWo9WAZuqm3buoSx8aO+RiZdJkqRdpGK3b/MqtFY2dSLXgh/mKZ3RRF0gBrH8x
         WkNTbSkj4ZEb9VagBXlDZGTxGsN5DDWIOvbN0poxVbZJUmDpNRw5x5S/o8sP5mjEsFHD
         re2kIML2sCxlXl7bBhcBNZ0ztIj5vle7l3j/Lzo8BKIAW6ep8QQz5Th2j0iqqpU9DQdS
         x2qhBdDEqBI7w9KVgdHPgw8BykA4t4XFF7I08aY2poZzOAr8RMw53Z3m+V6Q5QkP0qa1
         mgOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777080343; x=1777685143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca/F5kJ24z9kaZckQtyAE58YWNbnN15FN51lqLQH+dg=;
        b=QUX6m4h7GpzBRnxM9pHrgqJ0pbnBvwSYmlCdKUNWWX7J9m9I7RMTiqMAyGGqxIxgPy
         8ri64xyrq4kR5lELNGr2vYkwmxYcGh65WArKGQ/TRDwF7Gc2mnDzcdaXyAZlLoeZmq3o
         9l/GXElLtYs4UJq+PLN4pw4NHQjEA822s+L4zX9i2F9jr7k5XAC/G5knonvZk/JVxTZ4
         1mqFsWr7x5iS2JJbAuFwYFLa8qtJSv8eqFniieKUkBYfVkvHbz7p+19EYczJJLy+QAW4
         aLI1dUb99PZBjMisToTxrFdklTwiyYoFhM8otWjyz6uaDGl+w4YbpQGNdNTy6htI8oSJ
         s2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777080343; x=1777685143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ca/F5kJ24z9kaZckQtyAE58YWNbnN15FN51lqLQH+dg=;
        b=lhvBlpdyUrpLOoS0pT9dtf2L0so76mdXhFfDIZQgfOuuROQ6tgqOiqwyqAPjZjo40P
         09qUZLI/PRxlwJIwGaMSUWWLXX9Ox6DoQ+rK+7Hprj8I9qHX4AXATDCl1j4w5LFia/1B
         UQEQcDSKGxMS+uqRnidFc5GK36FeoGtppoDkXdC/vXdMCZfRw8k85akQuyJzXvejpQkj
         NxUYzdXy+q/u/I/k4yTAbBdMNjqD1y8WarY36H0Z+jTHBGuIIFgoLKBkflk3dydZwH6G
         GFrqVR9mB+dpNTw791Cs0v943MukpRUMMAN+x4Y5m5W+6Lim1C1ppPYLG+Ui/fAUnADA
         byfw==
X-Forwarded-Encrypted: i=1; AFNElJ+QgrIf9MWfTx03n4rhpAy2cruchO54bChBzWZ4LrgVIzpOxRYVPUrT7lJTY3CLu12vTbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9osYkXe2YS7sIWrywLOwqO+VGBCmLwXeBSdwgLtumif5TNcWK
	02SQ2V/jqQS3Jb3GAL+O4K9gZbp9177pBbihmFukeFWgid8j6rV8jAtQVy/I+q0t5kyKLRtLPxT
	OWu8GI6fuLq+evDQR+5l2VdSvs6F2gM0=
X-Gm-Gg: AeBDiesIIVETRZdybdIovR9Tt9iCuB2EtAEQys0uvobCkPAHjFRPXyBP9cnk+SlfF6P
	O+tcP99tNjJMV7KG2D/bFfyAdriy/+vwvCMvAn4yvtz4RFFFGXe44g9/QZYJc7kVG9ODfMrQDAZ
	1izy8oe0XIOx1RaVG4X9Wuc8ZTmXkhS99Gx9nLzf0CCz/HuLJ5bd/KxV0OOV6ZzbNiz5G6UFo1+
	yIWrsMmXKqqgNa9gYVn3RKcw9KHhc441IOYVaRNW12JA5VEE9BxZlQ2WTIzvQCC80bBkF4YfvR8
	YVx8HZ4SP1867DCVLi4X0GzIIrkQh4H8dgKaRsr3vpV0DvO54AOo+CP29OoqsQkGB3hzXwI9JwV
	JZ4ySUAv/O1j1IMPG4ajDfPeyhnLoXGn6IYM/
X-Received: by 2002:a05:600d:10:b0:489:1b0c:8b43 with SMTP id
 5b1f17b1804b1-4891b0c8c48mr292125135e9.1.1777080342596; Fri, 24 Apr 2026
 18:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424192252.695240-2-utilityemal77@gmail.com>
 <20260424195958.AED4EC19425@smtp.kernel.org> <aevOssMWH_Vm9CPG@zenbox>
 <CAADnVQKFtuX48V9Yy88GHGVbQyY30M3b3YBvZ2PmYt_-jbohpQ@mail.gmail.com> <aev6zU2vj6wmaRMG@zenbox>
In-Reply-To: <aev6zU2vj6wmaRMG@zenbox>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Apr 2026 18:25:31 -0700
X-Gm-Features: AQROBzAPgjjGtM28-9ZKZEA39SZlZvWxxoiVowyRrqrHZ6VM3m1ED2bg5H_9P4A
Message-ID: <CAADnVQJEXDh6=rKfUjuR_zjCcXfMAXUaXcXTWgUAx1-mWe_e-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF ID
To: Justin Suess <utilityemal77@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 4:20=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
>
> So either:
>
> 1. allocating memory for a new irq_work on the fly, which is an
> operation that can fail. So if we're under memory pressure the
> element never gets freed.
>
> 2. preallocate an irq work for every element ahead of time.

obviously that's not what I was referring to.
irq_work is rarely used directly like that.
The common pattern is:
defer_free()
{
        if (llist_add(head + s->offset, &df->objects))
                irq_work_queue(&df->work);

but before going there.
Please enumerate "other dtors broken in NMI".
What exactly is broken?
What is the sequence of events?
All map types with kptrs? or particular ones?
