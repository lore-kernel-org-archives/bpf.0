Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349627;
	b=rTd52ArXygEb5sITTm6Wvh6dsTcH59oS0ou3vh+ISfcU+QO2DWKk2SsZQ478jHLhnXIm
	 BhPz3sX/KTk+4T7BMRFWBnwquLETB4EeuEvbHBzdWuFLMSLtMhgonGkw3mg43n3fw7nD2
	 nbg6vQe7mIS0teyA7xHasxgX1Kt8LBpW0KqID2fXO0hQZp7CUozOcDsQGTGvGfwp2XaNj
	 6CWsGe7DnnFH5h0z92ZHNX/f1kGI6mXyqlsmN2xUiRri9bOOIx4i/asF7tTONSYNuNVV5
	 x8efMsa4uWbpHjaHHbuvWJCRan8JXwHnp4wlwYWioOOsgMoTqzMEKgUsvu3Av2GxsJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
	b=xryamodnSs8GdiUzC/j9nVz8whNv0gLOM3dPVTNlWDJ8P+YlCmSiHANihyBoy90wOnTw
	 REu2Q0ZGL+EvBesZE/MPSiKlbsYZHAFrH+taXVRlY3ElLt89eeUsLfGc5pEBSC48YFfys
	 m3zI5a0FdRnFyjvJMoXfLD/g5Jy09sUdGMw4pApRCYyzwOPcuzuoaA9+OO+FKir21qzwF
	 oQgrGoGgjD0DPO3CB+qHjwLSGu5VeXHEev5rv4oUZx7gM1FDorg5UFkrMkxTeon1DYFAj
	 uhR4a42mJN7pqZHPbNKjxlTLI5T85o29ZWDe0TubESTa3eTIes3U/dm7IfjElwX9G5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwGefDb1;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74C606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 08:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC74C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwGefDb1
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd8b58dd4c1so7862a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793349626; x=1793954426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
        b=hwGefDb1SWctrOe6SQdKvltFiVhjCBvK4nzZjKCLo7KEWh0S1Zef9SO464ErUQOnLK
         8FjZ1sDDtHIsonQIgKxdTbLw4uIwlQi2nGAu4hwzz932I4/O5msW4V89rV0kqfPaLFRU
         ZOMZ4hAF3PZ+bdVnT6jOMAnlLN0O6O2bNyLkCE38yNOTsQb+5ERP3XhcxZTbgSh8SEzT
         /gGQsfwAVL7tr+QOnNY7VjxbAkKIfyvzEwF8oaJytuHFBdkInK5U+5Jg6sYYnc4Yqwjo
         jNeC6Qp9fJRlf3KL++vTrCllFwypFsOFxMglcQOeCJww6ajRJy0ioYfNOuXNSBojxPhi
         gQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349626; x=1793954426;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
        b=1JMx8PzlKqdTVkpgHsGmuRv7mJIJuiaxeRoO19BAk1DCuZzYPDyy3NJYW/GzhKysec
         VP/o+jAj2eFrw+lHpE9Hct7bprRweIXlppnqmH9BoxWt4JuDDkX/GojEjXTEejnExLMY
         t5NjJyVIIYzEpO8gYvlU0A+mkfzzcamkrZdcMvrL/SBa6IenEdKTbLkuCJmwUrosPSAF
         fEgDqO6QVNAj51LGwNvvNbhztgGRb27PHXzzE10/bzvXDaccp7y/Ss5tSZs4/8eTWyW6
         UxutD2lXQsZ65RzGwII+xuWeejafhYGAqtv4EP2KBP/c+QXOlYxp0lPQ/65QPcagj3H/
         ZQAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRCfJlYnDhciRppWvrcXhTd4BVmFUx5q7b+x1DEU3PVoNrIuJj3VXe3peeGdCakc0fTVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYINruzABFNrbDslcBe+K1oPMnM/IfFRKucRSu2puvLKbKzo5JJ3
	+ppzfp/Y8wPxV5y7E/RdYnf+8pSMKCQWT9HphMT8n/tKYuDvLb+t1lPO
X-Gm-Gg: AYBFou3nHZSKHwOmefR4QMm8XWxrxTMoZjM/ypeEYVKPSwLnQIcpk+myTgVYB7I69p6
	9UOj6z6986w8no7QIkJextRLJdQArxQEha3AW55GBNyn7477JZ2WmCMxWL1gtY7yVU/4xMfVvv0
	bGJf5e842w0+htmefMeVAlQ/qpBqoqddeYDtNClqqoDfDlJiGnCrJHLzcSm/cylPWB5FwhnM0Rr
	QztIUTU6q1zmn/Lo6q560uM55DFbJhyfMeHqHGWJp1BOhStRS/JMTYvYhUeHd8i/c8An6na9rUT
	Ju0d+MLv8DMi0D3AhyONkh1FVbtCC/wiEnnFM8bcjn2Sj4mHO8oby4VDY91/Vk8kjl2ShRVCzhr
	/mlvehwiL76eqX9zsQT1MmZMKI46C6ekAtySXVqScr5bk9zOT4rQeK6+JMo93PhSERIsademZaO
	jC7vn5W5QFltxDRXutJBIiJrZmzK7GKF57cN1GC14QYdZkkwlOdI9FxwdatK3eEkmpBsjPKuHJu
	4xHNmPZkm1a3ePsuADC/H1xg4xE6Anr83pH/hB8hbu6l5qpwe9LkU2KNSb0uE3iXYjEHwZZ2owp
	Hgr6oG9prBtHVA67GdY9hmftKNvNDgHTXC5GCrfwxvuU5rc8iYziqdmN0Wc47Qc=
X-Received: by 2002:a05:6a20:2586:b0:3e1:9071:acb2 with SMTP id adf61e73a8af0-3e928a0b0bbmr1315570637.33.1793349626005;
        Fri, 30 Oct 2026 01:40:26 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2600:2f3f:1d83:9185:c6a1:9ca1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef96e53sm486051b3a.20.2026.10.30.01.40.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 01:40:25 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 16:40:17 +0800
Message-Id: <20261030084017.16202-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

Thanks for the review. This was a timing race, not intentional: your v3
reply (the Reviewed-by plus the else-branch nit) arrived at 10:30, while
v4 was sent at 10:32 and had already been prepared without it. I should
have checked the thread before sending.

I'll send a v5 as a new thread with the unnecessary else removed, exactly
as you suggested, and your Reviewed-by carried on patch 1. Patch 2 is
unchanged.

Thanks,
Rongzheng
