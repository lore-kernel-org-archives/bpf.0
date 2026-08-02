Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE3390229
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785713901; cv=none; b=ITkMTekR3sD0p4LvuoCibrCrjPQqKWuxCeQExTP3KCJq13b9O4tk99bsVFKBijGc0Uw0dgXF4dXIN0mdEglReQcicGSONZR8K7kCJ/GhuNvy1sikuTQfQNPlP9W5uy+okFoEQoZUN6VboNHujo863/K3x6GeDgcMsWK/izdGnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785713901; c=relaxed/simple;
	bh=+oVivUOlzG4DWDamKxr0o0Y+iC3QIaCQdzJTy/IbOgQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dNZVsdJjec/FrvJd3pGMUgf7p4Df86C/Hxfx+Z8p/wnjWA2FUPGjiy6uGqmOj7iV+izHLNcAu5t2cr/1EXsmmSIUJHj40wO+WS3HY0biu0AEy+GyB+imphNOWvVXvGZLe2TvQESwLGg2biBe/BY+Km66YCRRNjCcCgUKwsbG3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncDq/8MR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncDq/8MR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacb8416a1so26705755ad.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785713899; x=1786318699; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjoUynZVyetLFo7x/yUba6Zt9rYMhRjBHXBxc2twQlQ=;
        b=ncDq/8MRDrw9v5MFEYzSsQ2tcXSf5vGpZC1kyDA/rI3lQYrUbotlqhy/SrSxlb/gYe
         LTnsvnxaIEA0OcielioVaIjkai4qts7Io43QkRZFNuF20K3yxI5pXs4fbUt8JcsmqQg3
         NpCc9WQTVhghAIqkZhweHDvjU+S8Swu+FM79OplWsQIDIc/IqlfXdAVwg60iIRc8GNGn
         pvxA1UldaJ9Na3Wyc35yYzcLuv3mVN8EtZHl1oobiUkpHdRslymcg4z6zwfkdZ+z+cC/
         Onb9X58EevGqvXwElmjY2xWn0MM0MIFFDxkD5t4E76RLIASeQfJwOy/zIWqh7Itg0PgG
         h+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785713899; x=1786318699;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjoUynZVyetLFo7x/yUba6Zt9rYMhRjBHXBxc2twQlQ=;
        b=aHFpSHiRzse5odUc9kNmTTYwV/reoQpLo5kgKz8Rj/vSCMW87zIn7exBv0+QRt5rLL
         WToZ06gEbug10fjQlxPeRdANsRm+7+GHlT4YoKJ8P7cMuSNgSU51hhoaja1wzrI46W3H
         4Zx2arAahHtLu6aMIz9kJr4YPVMdmNN2buntFS2v9sAXujVzebjozICzEECpWbTya+1T
         WW2/zoSaUz+qIFx72EONw5GEbIq4fBR9e0USgznWusm5j+unfp55eBExzaTzOGmmnHFA
         h8iWKItytn/zSL7XIC9BSil3lzYINCCRWP8auVEaXNqFkXIbVXQ1uL2fxOQFnlyJX2RQ
         W3tA==
X-Forwarded-Encrypted: i=1; AHgh+RqzDo/UJybG/rerzcPE/md9WrXIzsB77of6rwOepl0eIJT7kKaNWUwXd1g9wvEaRhEFtF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZQxprcMQps7yJ5EX2N0kNbqKtoghE8Rm4nqQdDZSTv/ix2Za
	3DOVnZ3rb2oTLEPy+l5SkeLXPlpNv1KCRq9GcTT7eBvHBkFVOruJMuhBSwVkrwor
X-Gm-Gg: AR+sD11E1AJyOA+52v42qeR70Wi03Dvg3azHGuI+PP83xbzH5JldYuqsWqKY2SQ/paf
	uRNFhPSB9EQqmoGR5l3zyAlUXqdRfP782Xwo0av4/Hmqtw+/pEjXe3L2D3lhmByyeL9NqomBs4I
	KXTzJHfStn0CPcy1MNKbLdqzESo7tcuH/pkLhvcpzOrN4jzjNOFSsDw5P8Kb7TxlkKBHU+281Iu
	NV8u/bvEN0M001JM8zsA7FzLc8ew6HnJz8oxXXfESDtnaejMU082cIbh+JfsIBa4btDfUGq9+3Y
	Pa2q0iooluGby7mkSXMoYyRh0egYNAHQTR0y+9Lb7WamQTpMwSy4jk+MWq+IDb+JkvydEyTXvEJ
	8slTxyn0Npd/vWUkSq93t63KPrnQLGNaQyIrfgptc/Fcfwnayg6RP1vCcRN8Rhg+OY+PYM7UhUf
	5JrkC0gOSMg5S/n/Wu8e8ErIS686odyWycRfr/2F/EbC4kfJIRi18QzZgIZCsTgxPp4ayv8jh9T
	ByAIA==
X-Received: by 2002:a17:90b:56cc:b0:38e:69ae:7148 with SMTP id 98e67ed59e1d1-38fbc4d966amr6898529a91.24.1785713899432;
        Sun, 02 Aug 2026 16:38:19 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm35070094c88.12.2026.08.02.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/9] selftests/exec: let binfmt_flag_supported() return
 a bool
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-2-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-2-4a0b0da71f16@kernel.org>
Date: Sun, 02 Aug 2026 16:37:58 -0700
Message-Id: <178571387899.1880415.16506772757157668104.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 30 Jul 2026 15:34:04 +0200, Christian Brauner <brauner@kernel.org> wrote:
> binfmt_flag_supported() returns 0 when the flag is supported and -1
> when it is not, so every caller reads backwards:
> 
> 	if (binfmt_flag_supported('T'))
> 		SKIP(return, "kernel without the 'T' flag");
> 
> Make it return a bool and flip the callers. errno from a failed probe
> is still set for callers that check it.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
