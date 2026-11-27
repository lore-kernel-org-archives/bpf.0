Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815676;
	b=SWiM3ZOn9jB3IUxK0wO+KKfYZOZw8Ai5BKxBRQxfu2aMrbgIDFuFt9Rgf5fPe5knGQOR
	 G4Otx9Pf89cTUSe6My4Vn6N5sH5rTaPhSQ1KKe0rpmQHpXtqUxpv2eA1pjKRDUuhFKJLA
	 POPZWUMlMKvCB5PtomfJaVassEkfhWp7lw+ViuTr7z3k3nKw7ua2tcFH+LrUJNih4SeVZ
	 1HCa8jdj/vAmGOxXQ6U7yTI2S2g2WQ8UX7fsX+Cmr2uHEoGchRxwmeZ04P46IFQ4CLeH5
	 cfVHOqZh7eXp8+xMX8495IHaWhQdI+JuhfOVDPAQQDvp9cM536tORLkeAoM9cSHQJbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
	b=IRlqJcEBn8JM/Nfelczf9dlbM5aXtsjhDLJR+D048nH/ynhDsU09oyPXQrlu3lU4Wj9R
	 /l9K/QH7LHat2IHuvuuKEXDxIi4vcCOtIyRnawixbeOOyPfqS9s+8Zg0nKZ3PB5ZU4XJx
	 MA5tjxoR8tJRg//tOxNSUlCmUmcJpJNk96Pm3DoYq98R906s8AiE7YgEVBteDvHmvYgJ6
	 PK5HOWX+F3SXiRNLP1cHQmss1/tZT9vvL/2c/RCqFlefKaHxE71ojmZVfdS57ncbz2LmJ
	 q7PAaKpGKvX/BN1+qh1jHmO+9rfKSUEyqoR8XhZCHPv5OELZzeL0gxIBb/o0QZntwHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43084606A329
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 21:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43084606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso83007975e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815674; x=1796420474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=rlJzjc+LyIk9Bk0QS6P/I8TDEexyuBC3YqrMNuS8l9ecZxXqzecIXHrsa2+jjLCIkd
         AvdgA+lDcovhfWDGGXxDDTraLo/z7WixYN6CS0WFtDPjvWLKrdb2LmuL8SVsyVcmcUAE
         w7uKvqNGQ6fgCtW1/YqXftDsvKWqzLc/etNTUBIImSolgJ458EFpxfvonhxlMSH2he0w
         gpZYXR2cdjzW3qoLBTUFALao2MhHDceARIdwR8T5fNHKRhO5CZKehhou/RRtD33QzCTW
         J9VxQgQTSkBjmppRZyAfVgxgVnOD9jDbF3HW5K6gfIlLPnr/76nWxRQFxdk3GCbefAfK
         3+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815674; x=1796420474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=KMrK7fXc8SJHrhPQGWO4WyYDdCGmZYhPCdQZVxuQywgqiIEcPvsZyH97cXuLh7P4Y0
         KBIO9OvZkuuofbmPIObcZQ4hi7S+8W3/hAJ5H5kX9qCb2NmS0eTgLRzrRAkko4SzS/kf
         DovhG880b9UC7Yy16XMxLdvOEPtCx9E+XOo+c7blFODmYWHti/C6zns3UlMPtdScONpl
         DN6iOcQleeP5uxM1CncUzQVvpMT0VcS9DbJIq91atg8Kplc7ps03ZUu4CSeiCxph10To
         PPabY1kKxVLIyyWXam7t02wx+cs/uGNFyrnKf8x+gsKPlMvD9w8rLu8KDrUs7UrIQRRC
         Nexw==
X-Forwarded-Encrypted: i=1; AL+hErE9qRhQL0rhYDWeHzbuCS7hYj4y6UD/Pz/bhejnYNr40/h6APv7FCHJEZNgPItn5TUzA6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VlC+wSipSAkv+tNOE0lEd9lnruu4oDy74lXwGUqUW4EDe9wDZ
	OyShdbW23BqPaGWo+7rcY+bviM3Ce9BfodWu1YPuIcsZMivNTU84PtqR
X-Gm-Gg: AZFdTZeSlFNX83Nxu6LTi7SQ9ooB5P2eTeXZ2WBlvqAyWheS/p/mK2t9kmClNyP5514
	bYwNeKB3PjvUGYNMWavnbYwni7N9wMSf3uIWqP2nRyTUQ5RC/7l93ZHZchdAwhaHgcucqByEVed
	IMXGoR7q8DqO2h+64B6YnG5UvQqYIery8y3UDa4zTDJdw5l9MlEcJ1CTI5X/XREig+QPDwHFh1H
	1RIsHY7u78BmQFWAINRyaZQPgUaio1LvKaZbhI7OvGqrEBHEgmAnQ+eNJj/2f1skN8epzowhaax
	RM6W9vSjr/9Lf97yMpAhno2jla2JPZekSLHvMPcDWevGWdV5nr54lmopMIhXhmk6ZIdKT71z/So
	y3FzRxdGuMmvSlTDM4+lT+0hT2W5rE0C6ewpejb4M+aBGxYlKqU9ILqXTGyJEX+sezdz/ha/B7Z
	5qMLq00AM0mAGEG/qer7KFAGhoejSbkiFY9VAl/4efBilC4VP3jXaj/3lgDMmPXVvcn+gDndemt
	athDcKiy7Xy19wKFUu4J2GV6Xvz9ZkIV8s/Ltf2gGDX6G9VhmR3FyJHZIMtRqlnMXD+1+zzbHbh
	p2EHco3OM3foiL3o6QJUbjefYw==
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr518939935e9.11.1795815674386;
        Fri, 27 Nov 2026 13:41:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bbb97e5356sm37714445e9.4.2026.11.27.13.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 13:41:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	alexei.starovoitov@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 00:41:03 +0300
Message-ID: <20261127214103.542291-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awOQDOel_72Xwjm7@kernel.org>
References: <awOQDOel_72Xwjm7@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko Sakkinen <jarkko@kernel.org>:
> I personally think that "getting in" should not be a goal in the first
> place. I care more about that whaever gets in has a high bar of
> quality enough. It can be something different than this but
> when I read the LWN article about Cells I was alarmed enough
> so that I had to do this and prove my point.

I think that Bacik's patchset has better chances than yours.
I think so, because (as Bacik said) it was tested in Anthropic, and also
because Brauner reacted positively:
https://lore.kernel.org/all/20261021-zeitig-niemals-clubmitglieder-b3973fcebd38@brauner/ .

So I suggest reading Bacik's patchset and say what you don't like about it.
You will have chance to influence Bacik's proposal before it will be merged.

(Note: I am not kernel developer.)

-- 
Askar Safin
